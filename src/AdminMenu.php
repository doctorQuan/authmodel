<?php
namespace authmodel;

class AdminMenu extends Admin
{
	public $table_name 	=	"sys_menu";
	//1、根据当前用户查找菜单

	/**
	 * 获取用户的菜单列表(暂时只支持二级菜单)
	*/
	public function listShow($userid=0)
	{
		if($userid!=0){
			$admin_user_role = new AdminUserRole();
    	$role_list=$admin_user_role->getRoleByUid($userid);
    	if(!$role_list){
    		return array();
    	}
    	$in_ids='';
    	foreach($role_list as $key=>$role_info){
    		$in_ids .= "'".$role_info['id']."',";
    	}
    	$in_ids .="'0'";
    	$list=$this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id in (".$in_ids.") ");
		}else{
			$list 	=	$this->findAll(null,'sort asc,id asc','*');
		}
		$return_data = array();
		foreach($list as $key1=>$info){  //找出一级
      if($info['parentid']=='0' || !$info['parentid']){
        $info=$this->tranMenu($info);
        $info['name']=$info['name']."(".$info['remark'].")";
				$return_data[]=$info;
				foreach($list as $key2=>$info2){  //找出二级
						if($info2['parentid']==$info['id']){
              $info2=$this->tranMenu($info2);
							$info2['name'] = "&nbsp;&nbsp;&nbsp;&nbsp;﹂".$info2['name'];
							$return_data[]=$info2;
						}
				}
			}
		}
		return $return_data;
	}

	/**
	 * 根据管理员id获取,特指左侧菜单栏
	 */
	public function getMenuByAdminId($adminid)
	{
		$admin_user = new AdminUser();
		$user_info = $admin_user->getUserInfo($adminid);
		if(!$user_info){
			return false;
		}

		//判断是否是超级管理员
		if($user_info['is_supper_admin']=='99'){ //超级管理员不做菜单限制
			$menu_list=$this->query("select m.* from sys_menu as m where m.parentid='0' and m.is_visiable='1' order by sort asc");
      $menu_list=$this->tranMenu($menu_list);

      foreach($menu_list as $key=>$menu_info){
        $son_menu_list=$this->query("select m.* from sys_menu as m where m.parentid='".$menu_info['id']."' and m.is_visiable='1' order by sort asc");
        $son_menu_list=$this->tranMenu($son_menu_list);
				$menu_list[$key]['son_menu_list'] =$son_menu_list;
			}
			return $menu_list;
		}else{
			$admin_user_role = new AdminUserRole();
    	$role_list=$admin_user_role->getRoleByUid($adminid);
    	if(!$role_list){
    		return array();
    	}
    	$in_ids='';
    	foreach($role_list as $key=>$role_info){
    		$in_ids .= "'".$role_info['id']."',";
    	}
    	$in_ids .="'0'";
    	$menu_list=$this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id in (".$in_ids.") and m.parentid='0' and m.is_visiable='1' order by m.sort asc");
      $menu_list=$this->tranMenu($menu_list);
    	foreach($menu_list as $key=>$menu_info){
				$son_menu_list=$this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id in (".$in_ids.") and m.parentid='".$menu_info['id']."' and m.is_visiable='1' order by m.sort asc");
        $son_menu_list=$this->tranMenu($son_menu_list);
				$menu_list[$key]['son_menu_list'] =$son_menu_list;
			}
			return $menu_list;
		}
	}


  /**
   * 根据管理员id获取,特指左侧菜单栏
   */
  public function getDefaultMenuByAdminId($adminid)
  {
      $admin_user_role = new AdminUserRole();
      $role_list=$admin_user_role->getRoleByUid($adminid);
      if(!$role_list){
        return array();
      }
      $in_ids='';
      foreach($role_list as $key=>$role_info){
        $in_ids .= "'".$role_info['id']."',";
      }
      $in_ids .="'0'";
      $menu_list=$this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id in (".$in_ids.") and m.parentid='0' order by m.sort asc");
      $menu_list=$this->tranMenu($menu_list);
      foreach($menu_list as $key=>$menu_info){
        $son_menu_list=$this->query("select m.* from sys_role_menu as rm left join sys_menu as m on rm.sys_menu_id=m.id where rm.sys_role_id in (".$in_ids.") and m.parentid='".$menu_info['id']."' and m.default='1' order by m.sort asc");
        $son_menu_list=$this->tranMenu($son_menu_list);
        $menu_list = array_merge($menu_list,$son_menu_list);
      }
      foreach($menu_list as $menu_info){
        if($menu_info['default']=='1'){
          return $menu_info['link'];
        }
      }
      return false;

  }


	/*
	 获取下一级菜单
	*/
	public function getSonMenu($parentid){
		 $son_list=$this->findAll(array("parentid"=>$parentid));
     $son_list= $this->tranMenu($son_list);
		 return $son_list;
	}

	public function addMenu($data){
		$data['id']=$this->getGuid();
		$id=$this->create($data);
		return $data['id'];
	}

	public function delMenu($menu_id){
		$sys_menu_mvc = new ElfModel("sys_menu_mvc");
		$sys_menu_mvc->delete(array('menu_id'=>$menu_id)); //删除mvc 关系表

		$sys_role_menu = new ElfModel("sys_role_menu"); //删除该菜单与角色的关系
		$sys_role_menu->delete(array('sys_menu_id'=>$menu_id));

		//删除菜单
		//如果这个是父菜单，先删除子菜单
		$this->delete(array('parentid'=>$menu_id));
		$this->delete(array('id'=>$menu_id));

		return true;
	}

  public function getMenuDetail($menu_id){
    $menu_info=$this->find(array("id"=>$menu_id));
    $menu_title_array = @$this->myUnserialize($menu_info['name']);
    if(is_array($menu_title_array)){
      foreach($menu_title_array as $key=>$menu_name){
        $menu_info[$key."_name"]=$menu_name;
      }
    }
    $menu_info=$this->tranMenu($menu_info);
    return $menu_info;
  }

  public function updateMenu($id,$array){
    $this->update(array('id' => $id),$array);
  }

  /*
    根据当前语言，选择菜单显示名称
  */
  private function tranMenu($array){
    /*
      判断是否多维数组
    */
    if(@$array['name']){
      $name_arr=$this->myUnserialize($array['name']);
      $array['name']=$name_arr[$_SESSION['lang']];
    }else{
      foreach($array as $key=>$one){
        $name_arr=$this->myUnserialize($array[$key]['name']);
        $array[$key]['name']=$name_arr[$_SESSION['lang']];
      }
    }
    return $array;
  }

  /*
    获取菜单关联的模块方法
  */

  public function getMethod($menu_id){
    $menu_mvc=new ElfModel("sys_menu_mvc");
    $menu_list=$menu_mvc->findAll(array("menu_id"=>$menu_id),"moudle asc,controller asc,method asc");
    return $menu_list;
  }

  public function delMethod($method_id){
    $menu_mvc=new ElfModel("sys_menu_mvc");
    $menu_mvc->delete(array("id"=>$method_id));
    return true;
  }

  public function addMethod($data){
    $menu_mvc=new ElfModel("sys_menu_mvc");
    $id=$menu_mvc->create($data);
    return $id;
  }

  /*
    得到树形结构菜单
   */
  public function getMenuTree($parent_id=0){

    $menu_ids="'0'";
    if($parent_id){
      $role = new AdminUserRole();//菜单
      $role_menu=$role->getRoleMenu($parent_id);
      //当前角色拥有的权限
      foreach($role_menu as $val){
        $menu_ids .= ",'".$val['id']."'";
      }
      $menu_ids = "(".$menu_ids.")";
    }

    if($parent_id){
      $parent_menu_list=$this->query("select * from sys_menu where parentid='0' and id in ".$menu_ids." and ifchoose=1 order by sort asc");
    }else{
      $parent_menu_list=$this->findAll(array("parentid"=>'0','ifchoose'=>1),"sort asc");
    }

    $parent_menu_list=$this->tranMenu($parent_menu_list);
    foreach($parent_menu_list as $key=>$val){
      if($parent_id){
        $son_menu=$this->query("select * from sys_menu where parentid='".$val['id']."' and id in ".$menu_ids." and ifchoose=1 order by sort asc");
      }else{
        $son_menu=$this->findAll(array("parentid"=>$val['id'],'ifchoose'=>1),"sort asc");
      }
      $son_menu=$this->tranMenu($son_menu);
      $parent_menu_list[$key]['son_menu']=$son_menu;
    }
    return $parent_menu_list;
  }
}

 ?>