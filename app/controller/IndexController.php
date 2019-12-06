<?php
namespace Bank\Controller;

use Bank\Model\Customer;
use Bank\Model\Account;

class IndexController extends ControllerBase
{
    public function indexAction()
    {
        $customer_code = $this->request->get('customer_code');
        $this->view->customer_code = $customer_code;
    }

    public function listAction()
    {
        $draw = $this->request->get('draw', 'int', 0);
        $offset = $this->request->get('start', 'int', 0);
        $limit = $this->request->get('length', 'int', 3);
        $search = $this->request->get('search');

        $data = [];
        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = 0;
        $result['recordsFiltered'] = 0;
        $result['data'] = $data;

        // 查询客户信息
        $bind = [];
        $where = '1 = 1';

        // 只支持按账户编号精确查询
        if ($search['value'])
        {
            $where .= ' AND customer_code = :customer_code:';
            $bind['customer_code'] = $search['value'];
        }

        $customers = Customer::find([
            $where,
            'bind' => $bind,
            'offset' => $offset,
            'limit' => $limit
        ]);

        if (count($customers) <= 0)
        {
            return $this->response->setJsonContent($result);
        }

        // 客户总数
        $total = Customer::count([
            $where,
            'bind' => $bind
        ]);

        $customers = $customers->toArray();
        $customer_codes = array_column($customers, 'customer_code');
        $customer_code_sql = implode(',', $customer_codes);

        // 查询客户银行账户信息
        $phql = "SELECT customer_code, COUNT(*) as total_count, SUM(balance) as total_balance FROM ". Account::class ." WHERE customer_code IN ({$customer_code_sql}) GROUP BY customer_code";
        $result = $this->modelsManager->executeQuery($phql);

        $aggs = array_column($result->toArray(), null, 'customer_code');

        foreach ($customers as &$customer)
        {
            $customer['total_count'] = 0;
            $customer['total_balance'] = 0;

            if (isset($aggs[$customer['customer_code']]))
            {
                $customer['total_count'] = $aggs[$customer['customer_code']]['total_count'];
                $customer['total_balance'] = $aggs[$customer['customer_code']]['total_balance'];
            }
        }

        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = $total;
        $result['recordsFiltered'] = $total;
        $result['data'] = $customers;

        return $this->response->setJsonContent($result);
    }
}

