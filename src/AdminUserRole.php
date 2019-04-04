<?php
namespace authmodel;

/**
 * 后台管理员角色模型
 */
class AdminUserRole extends Admin
{
    public $table_name = 'sys_role';
    /**
     * 获取角色表里面的所有数据
     * @param  	[array] 		$condi 		[条件]
     * @param  	[string]  		$sort  		[排序]
     * @param  	[string] 		$field 		[获取字段]
     * @param 	[int]			$is_page	[是否使用分页]
     * @param 	[int] 			$page 		[页码]
     * @param 	[int]			$limt 		[条数]
     * @return 	[array]        				[返回array]
     */
    function roleList($condi = '', $sort = '', $field = '*', $is_page = 0, $page = 1, $limit = 10)
    {
        if ($is_page === 1) {
            $da = array($page, $limit);
        } else {
            $da = array();
        }
        $list = $this->findAll($condi, $sort, $field, $da);
        $count = $this->query("SELECT count(id) FROM sys_role");
        $arr = array();
        $user = new AdminUser();
        if(!$list){
            $data = array('code' => 0, 'count' => 0, 'msg' => '', 'data' => array());
            return $data;
        }
        foreach ($list as $v) {
            if (!empty($v['sys_user_id'])) {
                $username = $user->find(array('id' => $v['sys_user_id']), '', 'username');
                $v['parent_name'] = $username['username'];
                $arr[] = $v;
            }
        }
        if (!empty($arr)) {
            $list = $arr;
        }
        $data = array('code' => 0, 'count' => $count[0]['count(id)'], 'msg' => '', 'data' => $list);
        return $data;
    }
    /**
     * 根据用户id获取角色
     */
    public function getRoleByUid($uid)
    {
        $role_list = $this->query("select r.* from sys_user_role as ur left join sys_role as r on r.id=ur.role_id where ur.user_id=:user_id", array(":user_id" => $uid));
        return $role_list;
    }
    public function updateMenuSetting($menu_list, $role_id)
    {
        $sys_role_menu = new ElfModel("sys_role_menu");
        $sys_role_menu->delete(array("sys_role_id" => $role_id));
        foreach ($menu_list as $key => $val) {
            $array = array('sys_menu_id' => $val, 'sys_role_id' => $role_id);
            $sys_role_menu->create($array);
        }
        return true;
    }
    /*
    	角色拥有的菜单
    */
    public function getRoleMenu($role_id)
    {
        $menu_list = $this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id=:role_id ", array(":role_id" => $role_id));
        return $menu_list;
    }
    /*
      	角色详情
    */
    public function getRoleInfo($id)
    {
        $user_role = $this->find(array("id" => $id));
        return $user_role;
    }
    /*
      检查是否可以修改
    */
    public function ifChange($id)
    {
        $user_role = $this->find(array("id" => $id));
        if ($user_role['editable'] == '-1') {
            return false;
        }
        return true;
    }
    /*
     更新角色
    */
    public function updateRole($id, $data)
    {
        $user_role = $this->update(array("id" => $id), $data);
        return true;
    }
    /*
     更新角色
    */
    public function delRole($id)
    {
        $sys_role_menu = new ElfModel("sys_role_menu");
        $sys_role_menu->delete(array("sys_role_id" => $id));
        //删除菜单关联关系
        $user_role = new ElfModel('sys_user_role');
        $user_role->delete(array("role_id" => $id));
        //删除角色与管理员关系
        $this->delete(array("id" => $id));
        return true;
    }
    /*
      新增角色
    */
    public function addRole($data)
    {
        $data['id'] = $this->getGuid();
        $user_role = $this->create($data);
        return true;
    }
    /*
     通过名称，获取角色详情
    */
    public function getRoleByName($role_name)
    {
        $user_role = $this->find(array("role_name" => $role_name));
        return $user_role;
    }
    /**
     *  【获取经销商/厂家角色】
     */
    public function getAdminRoles(){
        return $this->findAll(['id <> "a1a9f0fff0c9e952c4f580ae3f766773"'],null, 'id,role_name as name');
    }

}