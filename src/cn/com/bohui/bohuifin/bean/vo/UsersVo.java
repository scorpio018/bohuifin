package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.UsersBean;

import java.io.Serializable;

/**
 * Created by yangyang on 2017/6/29 0029.
 */
public class UsersVo extends UsersBean implements Serializable {

    private String[] userIds;

    public String[] getUserIds() {
        return userIds;
    }

    public void setUserIds(String[] userIds) {
        this.userIds = userIds;
    }
}
