package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.DealerTalkBean;

import java.io.Serializable;

/**
 * Created by scorpioyoung on 2017/8/10 0010.
 */
public class DealerTalkVo extends DealerTalkBean implements Serializable {

    private Integer[] talkIds;

    public Integer[] getTalkIds() {
        return talkIds;
    }

    public void setTalkIds(Integer[] talkIds) {
        this.talkIds = talkIds;
    }
}
