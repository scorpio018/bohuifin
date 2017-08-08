package cn.com.bohui.bohuifin.bean;

import java.io.Serializable;

/**
 * Created by yangyang on 2017/6/26 0026.
 */
public class BaseUserBean extends BaseBean implements Serializable {

    private String pwd;

    private String salt;

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
}
