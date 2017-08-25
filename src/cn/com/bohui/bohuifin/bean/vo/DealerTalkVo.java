package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.DealerTalkBean;
import cn.com.bohui.bohuifin.bean.ProductBean;

import java.io.Serializable;

/**
 * Created by scorpioyoung on 2017/8/10 0010.
 */
public class DealerTalkVo extends DealerTalkBean implements Serializable {

    private Integer[] talkIds;

    private DealerBean dealerBean;

    private ProductBean productBean;

    public Integer[] getTalkIds() {
        return talkIds;
    }

    public void setTalkIds(Integer[] talkIds) {
        this.talkIds = talkIds;
    }

    public DealerBean getDealerBean() {
        return dealerBean;
    }

    public void setDealerBean(DealerBean dealerBean) {
        this.dealerBean = dealerBean;
    }

    public ProductBean getProductBean() {
        return productBean;
    }

    public void setProductBean(ProductBean productBean) {
        this.productBean = productBean;
    }
}
