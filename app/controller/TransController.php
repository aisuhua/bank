<?php
namespace Bank\Controller;

use Bank\Model\Account;
use Bank\Model\Trans;
use Bank\Model\Customer;

class TransController extends ControllerBase
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
        $customer_code = $this->request->get('customer_code');

        $data = [];
        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = 0;
        $result['recordsFiltered'] = 0;
        $result['data'] = $data;

        $account = Account::find([
            'customer_code = :customer_code:',
            'bind' => [
                'customer_code' => $customer_code
            ]
        ]);

        if (empty($account))
        {
            return $this->response->setJsonContent($result);
        }

        $acc_numbers = array_column($account->toArray(), 'acc_number');
        $acc_numbers_sql = implode(',', $acc_numbers);


        $where = "acc_number IN ($acc_numbers_sql)";
        $trans = Trans::find([
            $where,
            'offset' => $offset,
            'limit' => $limit
        ]);

        $total = Trans::count($where);
        $data = $trans->toArray();

        $result = [];
        $result['draw'] = $draw + 1;
        $result['recordsTotal'] = $total;
        $result['recordsFiltered'] = $total;
        $result['data'] = $data;

        return $this->response->setJsonContent($result);
    }
}

