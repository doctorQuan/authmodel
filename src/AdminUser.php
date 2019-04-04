<?php
namespace authmodel;

/**
* 后台管理员模型
*/
class AdminUser extends Admin
{
	public $table_name 	=	"sys_user";

	/**
	 * 获取管理员列表
	 * @param  array  $condi  [筛选条件]
	 * @param  string  $sort  [排序方式]
	 * @param  string  $field [指定获取字段]
	 * @param  integer $page  [页码]
	 * @param  integer $limit [条数]
	 * @return JSON           [返回json数据]
	 */
	function userList($condi='',$sort='',$field='*',$page=1,$limit=10)
	{
		$start=($page-1)*$limit;
		$list 	=	$this->findAll($condi,$sort,$field,"$start,$limit");
		$count 	=	$this->findCount($condi);
		$AdminUserRole=new AdminUserRole();
		$da 	=	array();
		foreach ($list as $v) {
				$role_list=$AdminUserRole->getRoleByUid($v['id']);
				$v['role_name'] = '';
				foreach($role_list as $role_info){ //暂时只有一条
					$v['role_name']=$role_info['role_name'];
				}

				//$admin_detail=new \AdminDetail();
				//$v['parent_name']=$admin_detail->getUserRoleName($v['id']);
        $da[]	=	$v;
		}
		$demo =	array('code'=>0,'count' => $count,'msg'	=>'','data' =>$da);

		return $demo;
	}

	/**
	 * 通过管理员id获取所有的父级id
	 * @param  string 	$userid 	管理员账号id
	 * @return array 	$data 		返回一维数组
	 */
	public function parentidList($userid)
	{
		static 	$data = array();
		$resu 	=	$this->find(array('id' => $userid),'','id,parentid');
		if(!empty($resu))
		{
			array_push($data,$resu['id']);
			$this->parentidList($resu['parentid']);
		}
		return $data;
	}

	/**
	 * 根据管理员id删除账号
	 * @param  string 	$id 	账号id
	 * @return JSON
	 */
	public function userDel($id)
	{
		$user_role 	=	new ElfModel('sys_user_role');
		$user_role->delete(array('user_id' => $id));
		$this->delete(array('id' => $id));
		return true;
	}


	/**
	 * 通过管理员id获取管理员详情
	*/
	public function getUserInfo($userid)
	{
		$user_info 	=	$this->find(array('id' => $userid));
		/*
			查找所属角色
		*/
	  if($user_info){
			$user_role 	=	new ElfModel('sys_user_role');
			$role_info 	=	$user_role->find(array("user_id"=>$userid));
			$user_info['role_id']=$role_info['role_id'];
	  }
		return $user_info;
	}

	/*
		添加管理员
	*/
	public function addUser($role_id,$user){
		$user['id'] 		= 	$this->getGuid();
		/*管理员信息保存*/
		$this->create($user);

		$user_role_da	=	array('user_id' =>$user['id'],'role_id' => $role_id);
		/*保存管理员与角色关联信息*/
		$user_role 	=	new ElfModel('sys_user_role');
		$user_role->create($user_role_da);
		return $user['id'];
	}


	/*
		添加管理员
	*/
	public function updateUser($id,$roleid,$new_data){
		$this->update(array("id"=>$id),$new_data);

		$user_role_da	=	array('user_id' =>$id,'role_id' => $roleid);
		/*保存管理员与角色关联信息*/
		$user_role 	=	new ElfModel('sys_user_role');
		$user_role->delete(array('user_id' =>$id));
		$user_role->create($user_role_da);
		return $id;
	}


	/**
	 * 登录验证
	 * @param  [string] $username [用户名称]
	 * @param  [string] $password [密码]
	 * @return [json]             [返回提示]
	 */
	public function verification($username,$password)
	{

		$resu 	=	$this->find(array("username" => $username,"status" => 1),'','id,username,truename,password,status,is_supper_admin');
		if(!empty($resu))
		{
			$pwd 	=	$this->mymd5_4($password);

			if($pwd === $resu['password'])
			{
				return $resu;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
		return false;
	}

	public function getUserByUserName($username){
		$user_info 	=	$this->find(array('username' => $username));
		return $user_info;
	}

	/**
     *  【更改密码】
     */
	public function updatePassword($userID, $newPassword){
	    return $this->update(['id = :id', ':id'=> $userID], ['password'=> $this->mymd5_4($newPassword)]);
  }
}

 ?>