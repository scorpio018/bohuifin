package cn.com.bohui.bohuifin.service.dealer;/** * 表名：t_dealer */import cn.com.bohui.bohuifin.bean.DealerBean;import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.vo.DealerVo;import cn.com.bohui.bohuifin.common.Tools;import cn.com.bohui.bohuifin.consts.ParamConst;import cn.com.bohui.bohuifin.consts.SystemConst;import cn.com.bohui.bohuifin.mapper.DealerMapper;import cn.com.bohui.bohuifin.util.FileUtils;import cn.com.bohui.bohuifin.util.LogicUtil;import org.springframework.stereotype.Service;import org.springframework.web.multipart.MultipartFile;import javax.annotation.Resource;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpSession;import javax.util.zz.StringUtil;import java.util.List;import java.util.Map;@Servicepublic class DealerService {    @Resource    private DealerMapper dealerMapper;    public void saveDealer(DealerBean dealerBean, MultipartFile file) throws Exception {        if (file != null && !file.isEmpty()) {            String filePath = FileUtils.saveFile(file);            dealerBean.setHeadImg(filePath);        }        dealerMapper.saveDealer(dealerBean);    }    public void updatePwd(DealerBean dealerBean) throws Exception {        dealerMapper.updatePwd(dealerBean);    }    public void updateDealer(DealerBean dealerBean, MultipartFile file) throws Exception {        if (file != null && !file.isEmpty()) {            String filePath = FileUtils.saveFile(file);            dealerBean.setHeadImg(filePath);        }        dealerMapper.updateDealer(dealerBean);    }    public List<DealerBean> listDealerByPage(Page<DealerBean> page) throws Exception {        return dealerMapper.listDealerByPage(page);    }    public List<DealerBean> listAllDealers(Map<String, Object> params) throws Exception {        return dealerMapper.listAllDealers(params);    }    public List<DealerBean> listAllDealers4View(Map<String, Object> params) throws Exception {        return dealerMapper.listAllDealers4View(params);    }    public List<DealerVo> listAllDealersJoinProducts(Map<String, Object> params) throws Exception {        return dealerMapper.listAllDealersJoinProducts(params);    }    public DealerBean findDealerById(String dealerId) throws Exception {        return dealerMapper.findDealerById(dealerId);    }    public void removeDealerById(DealerBean dealerBean) throws Exception {        dealerMapper.removeDealerById(dealerBean);    }    public void removeDealersById(DealerVo dealerVo) throws Exception {        dealerMapper.removeDealersById(dealerVo);    }    public boolean isLogin(DealerBean dealerBean, HttpSession session) throws Exception {        dealerBean.setState(SystemConst.STATE_DEFAULT);        DealerBean login = dealerMapper.getDealerBean(dealerBean);        return LogicUtil.getInstance().checkIsLogin(login, dealerBean, ParamConst.DEALER_LOGIN, session);    }    public boolean checkDealerExist(String dealerId, String dealerName, int authorityGroupId) throws Exception {        DealerBean dealerBean = new DealerBean();        dealerBean.setDealerId(dealerId);        dealerBean.setDealerName(dealerName);        dealerBean.setAuthorityGroupId(authorityGroupId);        dealerBean.setState(SystemConst.STATE_DEFAULT);        DealerBean result = dealerMapper.getDealerBean(dealerBean);        if (result != null) {            return true;        } else {            return false;        }    }    public boolean savePassword(HttpServletRequest request, String oldPwd, String newPwd) throws Exception {        DealerBean curLoginDealerBean = LogicUtil.getInstance().getCurLoginDealerBean(request.getSession());        if (isValidPassword(curLoginDealerBean, oldPwd)) {            curLoginDealerBean.setPwd(Tools.encodePassword(newPwd, curLoginDealerBean.getSalt()));            updatePwd(curLoginDealerBean);            return true;        }        return false;    }    public boolean isValidPassword(DealerBean dealerBean,String oldPwd)throws Exception {        if (dealerBean == null) {            return false;        } else {            if(dealerBean.getPwd().equals(StringUtil.MD5(StringUtil.MD5(oldPwd, "UTF-8")+dealerBean.getSalt(), "UTF-8"))) {                return true;            } else {                return false;            }        }    }}