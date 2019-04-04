<?php
namespace authmodel;
/**
* 后台管理员模型
*/
class Admin extends ElfModel
{
  public function getGuid($upper = FALSE, $hyphen = ""){
    $charid = md5(uniqid(mt_rand(), true));
    if ($upper) {
        $charid = strtoupper($charid);
    }
    $uuid = substr($charid, 0, 8) . $hyphen
            . substr($charid, 8, 4) . $hyphen
            . substr($charid, 12, 4) . $hyphen
            . substr($charid, 16, 4) . $hyphen
            . substr($charid, 20, 12);
    return $uuid;
  }

  /**
   * 密码加密方法
   * @param  [string] $data [密码密文]
   * @return [string]       [加密后的密文]
   */
  public function mymd5_4($data) {
      //先得到密码的密文
      $data = md5($data);
      //再把密文中的英文母全部转为大写
      $data = strtoupper($data);
      //最后再进行一次MD5运算并返回
      return strtoupper(md5($data));
  }

  public function myUnserialize($data) {
    return unserialize($data);
  }


}