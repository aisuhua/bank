<?php
namespace Bank\Model;

use Phalcon\Mvc\Model;

class Customer extends Model
{
    public $id;
    public $customer_code;
    public $customer_name;
    public $profile;
    public $command;
    public $update_time;
    public $create_time;

    public function initialize()
    {

    }
}