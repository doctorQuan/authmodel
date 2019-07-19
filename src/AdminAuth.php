<?php
namespace authmodel;
/**
* 后台管理员模型
*/
class AdminAuth extends Admin
{


  /**
   * 根据角色id查找menu下的mvc
  */
  private function getMvcByRoleId($role_id){
    $role=new AdminUserRole();
    $menu_list=$role->getRoleMenu($role_id);
    $mvc_list=array();
    $sys_menu_mvc=new ElfModel("sys_menu_mvc");
    foreach ($menu_list as $key => $value) {
      $mvc_arr=$sys_menu_mvc->findAll(array("menu_id"=>$value['id']));
      foreach($mvc_arr as $mvc_info){
        $key_str=strtolower($mvc_info['moudle'].$mvc_info['controller'].$mvc_info['method']);
        $mvc_list[$key_str]=$mvc_info; //用$key_str 作为key 值，防止重复
      }
    }
    return $mvc_list;
  }

  public function getAuthList($uid){
    $admin_user_role = new AdminUserRole();
    $role_list=$admin_user_role->getRoleByUid($uid);
    $mvc_list=array();
    foreach($role_list as $role_info){
      $mvc_list1=$this->getMvcByRoleId($role_info['id']);
      foreach($mvc_list1 as $key=>$val){
        $mvc_list[$key]=$val;
      }
    }
    return $mvc_list;
  }

  /*
    权限管理
  */
  function authCheck($user_id,$module,$controller_name,$action_name){
    $AdminUser=new AdminUser();
    $user_info=$AdminUser->getUserInfo($user_id);
    if($user_info['is_supper_admin'] == '99'){
      return true;
    }

    $admin_auth=new AdminAuth;
    $mvc_list=$admin_auth->getAuthList($user_id);

    $key_str=$module.$controller_name.$action_name;
    $key_str2=strtolower($module.$controller_name.'*');
    $key_str=strtolower($key_str);
    if(!@$mvc_list[$key_str] && !@$mvc_list[$key_str2]){
      //没有权限
      return false;
    }else{
      //操作日志
      $data = json_encode($_REQUEST);
      $AdminUserLog=new AdminUserLog();
      $AdminUserLog->addLog($user_id,$module,$controller_name,$action_name,$data);
      return true;
    }
  }



}

 ?>