<?php
namespace Bank\Controller;

use Bank\Model\Customer;
use Bank\Model\Account;

class AccountController extends ControllerBase
{
    public function indexAction()
    {
        $customer_code = $this->request->get('customer_code');
        $this->view->customer_code = $customer_code;

        $customer = Customer::findFirst([
            "customer_code = :customer_code:",
            'bind' => [
                'customer_code' => $customer_code
            ]
        ]);

        $this->view->customer = $customer;
    }

    public function listAction()
    {
        $draw = $this->request->get('draw', 'int', 0);
        $offset = $this->request->get('start', 'int', 0);
        $limit = $this->request->get('length', 'int', 3);
        $search = $this->request->get('search');
        $customer_code = $this->request->get('customer_code');

        $data = [];
        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = 0;
        $result['recordsFiltered'] = 0;
        $result['data'] = $data;

        $bind = [];
        $where = '1 = 1';
        if ($customer_code)
        {
            $where .= ' AND customer_code = :customer_code:';
            $bind['customer_code'] = $customer_code;
        }

        $account = Account::find([
            $where,
            'bind' => $bind,
            'offset' => $offset,
            'limit' => $limit
        ]);

        if (count($account) <= 0)
        {
            return $this->response->setJsonContent($result);
        }

        $total = Account::count([
            $where,
            'bind' => $bind
        ]);

        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = $total;
        $result['recordsFiltered'] = $total;
        $result['data'] = $account->toArray();

        return $this->response->setJsonContent($result);
    }
}

