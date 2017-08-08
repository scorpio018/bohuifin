package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.ProductProductTagBean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by yangyang on 2017/7/7 0007.
 */
public class ProductProductTagVo extends ProductProductTagBean implements Serializable {

    private List<String> tagNames;

    private int prevState;

    public List<String> getTagNames() {
        return tagNames;
    }

    public void setTagNames(List<String> tagNames) {
        this.tagNames = tagNames;
    }

    public int getPrevState() {
        return prevState;
    }

    public void setPrevState(int prevState) {
        this.prevState = prevState;
    }
}
