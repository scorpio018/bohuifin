package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.ManagerBean;

import java.io.Serializable;

/**
 * Created by yangyang on 2017/6/29 0029.
 */
public class ManagerVo extends ManagerBean implements Serializable {

    private String[] managerIds;

    public String[] getManagerIds() {
        return managerIds;
    }

    public void setManagerIds(String[] managerIds) {
        this.managerIds = managerIds;
    }
}
