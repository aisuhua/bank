<?php

/**
 * @link https://www.php.net/manual/zh/function.var-export.php#54440
 * @param $var
 * @param bool $return
 * @return mixed|string
 */
function var_export_min($var, $return = false)
{
    if (is_array($var))
    {
        $toImplode = array();
        foreach ($var as $key => $value)
        {
            $toImplode[] = var_export($key, true).' => '.var_export_min($value, true);
        }
        $code = '['.implode(', ', $toImplode).']';
        if ($return) return $code;
        else echo $code;
    }
    else
    {
        return var_export($var, $return);
    }
}

/**
 * 获取客户端 IP
 * @return string
 */
function get_client_ip()
{
    static $real_ip;
    if ($real_ip)
    {
        return $real_ip;
    }

    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    {
        $ips = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        foreach ($ips as $ip)
        {
            $ip = trim($ip);
            if (filter_var($ip, FILTER_VALIDATE_IP))
            {
                $real_ip = $ip;
                return $real_ip;
            }
        }
    }
    elseif (isset($_SERVER['HTTP_X-Real-IP']))
    {
        $real_ip = trim($_SERVER['HTTP_X-Real-IP']);
    }
    elseif (isset($_SERVER['REMOTE_ADDR']))
    {
        $real_ip = trim($_SERVER['REMOTE_ADDR']);
    }

    if (filter_var($real_ip, FILTER_VALIDATE_IP))
    {
        return $real_ip;
    }

    $real_ip =  '0.0.0.0';
    return $real_ip;
}