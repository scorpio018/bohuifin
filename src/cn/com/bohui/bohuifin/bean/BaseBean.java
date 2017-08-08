package cn.com.bohui.bohuifin.bean;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by yangyang on 2017/6/29 0029.
 */
public class BaseBean implements Serializable {

    private int listOrder;
    // 创建日期
    private Timestamp createTime;

    private String createBy;

    private Timestamp updateTime;

    private String updateBy;

    // 状态
    private int state;

    public int getListOrder() {
        return listOrder;
    }

    public void setListOrder(int listOrder) {
        this.listOrder = listOrder;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
