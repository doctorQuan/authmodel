<?php
namespace authmodel;

class ActionRead{
  var $controller_path = './protected/controller';
  /*
    获取当前文件夹下面方法（action开头的类方法）
    return 格式如下：
      array(
        "模块名"=>array(
          "控制器名"=>array(
            "*",
            "方法名1",
            "方法名2",
            "方法名3",
            "方法名4"
          )
        )
      )
  */
  public function getActionList(){
      $dir1 = $this->controller_path;
      $file_arr = array();
      if($dir2 = @opendir($dir1.'/')) {
          while (($key1 = readdir($dir2)) !== false) {
              // 读取模块文件名
              if (@is_dir($dir1.'/'.$key1) && $key1 != '.' && $key1 != '..') {
                  $file_arr[$key1] = array();
                  if($dir3 = @opendir($dir1.'/'.$key1.'/')){
                      while (($key2 = readdir($dir3)) !== false) {
                          // 读取控制器文件名
                          @$pathinfo = pathinfo($key2);
                          $controller = pathinfo($key2)['filename'];
                          if($pathinfo && $pathinfo['extension'] == 'php'){
                              if (@is_file($dir1.'/'.$key1.'/'.$key2) && $key2 != '.' && $key2 != '..') {
                                  $file_arr[$key1][$controller] = array();
                                  $file_arr[$key1][$controller][] = '*';
                                  $str2 = file_get_contents('./protected/controller/'.$key1.'/'.$key2);
                                  preg_match_all('/function[ ]+action[A-Z]+[^(]/i', $str2, $matches);
                                  foreach($matches[0] as $matches_val){
                                      // 读取方法名
                                      $method = explode(' ', $matches_val)[1];
                                      $file_arr[$key1][$controller][] = $method;
                                  }
                              }
                          }
                      }
                      closedir($dir3);
                  }
              }
          }
          closedir($dir2);
      }
      return $file_arr;
  }
}