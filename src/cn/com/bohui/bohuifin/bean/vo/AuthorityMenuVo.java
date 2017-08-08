package cn.com.bohui.bohuifin.bean.vo;

import cn.com.bohui.bohuifin.bean.AuthorityBean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by yangyang on 2017/6/30 0030.
 */
public class AuthorityMenuVo implements Serializable {

    private AuthorityBean authorityBean;

    private List<AuthorityMenuVo> authorityMenuVoList;

    public AuthorityBean getAuthorityBean() {
        return authorityBean;
    }

    public void setAuthorityBean(AuthorityBean authorityBean) {
        this.authorityBean = authorityBean;
    }

    public List<AuthorityMenuVo> getAuthorityMenuVoList() {
        return authorityMenuVoList;
    }

    public void setAuthorityMenuVoList(List<AuthorityMenuVo> authorityMenuVoList) {
        this.authorityMenuVoList = authorityMenuVoList;
    }
}
