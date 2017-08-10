package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.ProductBean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by yangyang on 2017/6/29 0029.
 */
public class DealerVo extends DealerBean implements Serializable {

    private String[] dealerIds;

    private List<ProductBean> productBeans;

    public String[] getDealerIds() {
        return dealerIds;
    }

    public void setDealerIds(String[] dealerIds) {
        this.dealerIds = dealerIds;
    }

    public List<ProductBean> getProductBeans() {
        return productBeans;
    }

    public void setProductBeans(List<ProductBean> productBeans) {
        this.productBeans = productBeans;
    }
}
