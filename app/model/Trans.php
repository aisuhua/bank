<?php
namespace Bank\Model;

use Phalcon\Mvc\Model;

class Trans extends Model
{
    public $id;
    public $acc_number;
    public $trans_time;
    public $amount;
    public $opp_acc_number;
    public $opp_customer_name;
    public $update_time;
    public $create_time;

    public function initialize()
    {

    }
}