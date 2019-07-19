<?php
namespace authmodel;

class AdminUserLog extends Admin{
    public $table_name = "sys_user_log";
    /**
     *  【日记添加】
     */
    public function addLog($user_id,$moudle,$controller,$action,$data){
        $month_age = date("Y-m-d H:i:s",time()-60*60*24*30); //三十天前
        $this->execute("delete from sys_user_log where create_time<'".$month_age."'");
        $this->execute("OPTIMIZE TABLE sys_user_log");

        $this->create(
            array(
                "user_id"=>$user_id,
                "moudle"=>$moudle,
                "controller"=>$controller,
                "action"=>$action,
                "data"=>$data,
                "create_time"=>date("Y-m-d H:i:s")
              )
        );
    }
}