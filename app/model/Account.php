<?php
namespace Bank\Model;

use Phalcon\Mvc\Model;

class Account extends Model
{
    public $id;
    public $customer_code;
    public $acc_number;
    public $open_org;
    public $balance;
    public $update_time;
    public $create_time;

    public function initialize()
    {

    }
}