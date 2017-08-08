package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.OperStateBean;
import cn.com.bohui.bohuifin.bean.ProductBean;
import cn.com.bohui.bohuifin.bean.ProductTypeBean;

import java.io.Serializable;

/**
 * Created by yangyang on 2017/6/30 0030.
 */
public class ProductVo extends ProductBean implements Serializable {

    private String[] productIds;

    private Integer[] tagIds;

    private String tagNames;

    private DealerBean dealerBean;

    private ProductTypeBean productTypeBean;

    private OperStateBean operStateBean;

    private boolean hasCurDayIncome;

    public String[] getProductIds() {
        return productIds;
    }

    public void setProductIds(String[] productIds) {
        this.productIds = productIds;
    }

    public Integer[] getTagIds() {
        return tagIds;
    }

    public void setTagIds(Integer[] tagIds) {
        this.tagIds = tagIds;
    }

    public String getTagNames() {
        return tagNames;
    }

    public void setTagNames(String tagNames) {
        this.tagNames = tagNames;
    }

    public DealerBean getDealerBean() {
        return dealerBean;
    }

    public void setDealerBean(DealerBean dealerBean) {
        this.dealerBean = dealerBean;
    }

    public ProductTypeBean getProductTypeBean() {
        return productTypeBean;
    }

    public void setProductTypeBean(ProductTypeBean productTypeBean) {
        this.productTypeBean = productTypeBean;
    }

    public OperStateBean getOperStateBean() {
        return operStateBean;
    }

    public void setOperStateBean(OperStateBean operStateBean) {
        this.operStateBean = operStateBean;
    }

    public boolean isHasCurDayIncome() {
        return hasCurDayIncome;
    }

    public void setHasCurDayIncome(boolean hasCurDayIncome) {
        this.hasCurDayIncome = hasCurDayIncome;
    }
}
