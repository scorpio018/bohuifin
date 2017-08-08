package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.DealerBean;

import java.io.Serializable;

/**
 * Created by yangyang on 2017/6/29 0029.
 */
public class DealerVo extends DealerBean implements Serializable {

    private String[] dealerIds;

    public String[] getDealerIds() {
        return dealerIds;
    }

    public void setDealerIds(String[] dealerIds) {
        this.dealerIds = dealerIds;
    }
}
