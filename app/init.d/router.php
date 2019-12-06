<?php
/**
 * @var Phalcon\Mvc\Router $router;
 * @var Phalcon\Di $di;
 */

$router = $di->get('router');

$router->handle();