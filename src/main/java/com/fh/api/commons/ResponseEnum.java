package com.fh.api.commons;

public enum ResponseEnum {

    USERNAME_PASSWORD_IS_ERROR(1000,"用户名或密码错误"),
    USERNAME_IS_ERROR(1001,"用户名不存在"),
    PASSWORD_IS_ERROR(1002,"密码错误"),
    USERNAME_PASSWORD_IS_NULL(1003,"用户名或密码为空"),
    USERNAME_USER_IS_LOCK(1004,"帐户已锁定"),
    USERNAME_USER_IS_SUCCESS(1005,"帐户已解锁"),
    USER_IS_UNLOCK(1006,"帐户已解锁 请重新登录"),
    USER_PASSWORD_IS_NOTNULL(1007,"输入的信息不能为空"),
    USER_PASSWORD_UNEQUALLY(1008,"新密码与确认密码不一致"),
    USER_OLD_PASSWORD_UNEQUALLY(1009,"旧密码输入错误"),
    USER_UPDATE_PASSWORD(1010,"密码修改成功，请重新登录"),
    USER_RESET_PASSWORD(1011,"密码重置成功，默认密码为123"),
    USER_IS_NULL(1012,"用户为空"),
    USER_EMAIL_IS_NULL(1013,"邮箱不存在"),
    UPDATE_EMAIL_PASSWORD_IS_SUCCESS(1014,"新密码已发送到邮箱"),


            ;

    private Integer code;
    private String msg;





    private ResponseEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }



    public Integer getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
