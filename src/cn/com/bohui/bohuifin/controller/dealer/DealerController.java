package cn.com.bohui.bohuifin.controller.dealer;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.Page;
import cn.com.bohui.bohuifin.bean.vo.DealerVo;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.common.FileUploadCheckUtil;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.*;
import cn.com.bohui.bohuifin.enums.EnumAuthGroup;
import cn.com.bohui.bohuifin.service.authority_group.AuthorityGroupService;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.util.zz.StringUtil;
import java.util.List;

/**
 * Created by Administrator on 2017/5/2 0002.
 */
@Controller
@RequestMapping(value = "/admin/dealers")
public class DealerController {

    @Resource
    private DealerService dealerService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @Resource
    private AuthorityGroupService authorityGroupService;

    @RequestMapping("/showDealer")
    public String showDealer(HttpServletRequest request, HttpServletResponse response, Page<DealerBean> page) throws Exception {
        request.setAttribute("page", page);
//        loginService.saveMenu(request, "menu-dealer");
        return "WEB-INF/dealer/showDealer";
    }

    @RequestMapping(value = "/dealerData")
    @ResponseBody
    public Page<DealerBean> getDealerData(HttpServletRequest request, HttpServletResponse response, String keyword, DealerBean dealerBean, Page<DealerBean> page) throws Exception {
        List<DealerBean> result;
        if (dealerBean == null) {
            dealerBean = new DealerBean();
        }
        dealerBean.setState(SystemConst.STATE_DEFAULT);
        page.setVo(dealerBean);
        if (!StringUtil.isEmpty(keyword)) {
            page.getParams().put("keyword", "%" + Tools.DLEC(keyword) + "%");
        }
        result = dealerService.listDealerByPage(page);
        page.setResults(result);
        return page;
    }

    @RequestMapping("/showAddDealer")
    public String addDealerBegin(HttpServletRequest request, HttpServletResponse response, Page<DealerBean> page, DealerBean dealer, String act, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (ParamConst.ACT_ADD.equals(act)) {
            dealer.setDealerId(sequencesService.getId());
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            DealerBean result = dealerService.findDealerById(dealer.getDealerId());
            if (result == null) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.NO_USER);
                return showDealer(request, response, page);
            }
            dealer = result;
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.UNKNOWN_ERROR);
            return showDealer(request, response, page);
        }
        request.setAttribute("dealer", dealer);
        request.setAttribute("act", act);
        return "WEB-INF/dealer/addDealer";
    }

    @RequestMapping(value = "/saveDealer", method = RequestMethod.POST)
    public String saveDealer(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "headImgFile") MultipartFile[] files, Page<DealerBean> page, DealerBean dealer, String act, String keyword) throws Exception {
        // 去掉管理员名中的前后空格
        dealer.setDealerName(dealer.getDealerName().trim());
        dealer.setAuthorityGroupId(EnumAuthGroup.DEALER.value());
        boolean isDealerExists = dealerService.checkDealerExist(dealer.getDealerId(), dealer.getDealerName(), dealer.getAuthorityGroupId());
        if (isDealerExists) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.USER_EXIST);
            return addDealerBegin(request, response, page, dealer, act, keyword);
        }
        MultipartFile file = null;
        if (files.length == 1) {
            file = files[0];
        }
        if (file != null && !file.isEmpty()) {
            String result = FileUploadCheckUtil.checkFileCanUpload(file);
            if (result != null) {
                request.setAttribute(ParamConst.ERROR_MSG, result);
                return addDealerBegin(request, response, page, dealer, act, keyword);
            }
        }
        if (ParamConst.ACT_ADD.equals(act)) {
            dealer.setDealerId(sequencesService.getId());
            dealer.setAuthorityGroupId(EnumAuthGroup.DEALER.value());
            LogicUtil.getInstance().saveParamsBeforeInsert(dealer, request);
            Tools.setUserSaltAndPassword(dealer, dealer.getPwd());
            dealerService.saveDealer(dealer, file);
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            LogicUtil.getInstance().saveParamsBeforeUpdate(dealer, request);
            dealerService.updateDealer(dealer, file);
        }
        cacheUtils.getDealerCache().refreshCache(dealer.getDealerId());
        return "redirect:" + SystemConst.BASE_PATH + "admin/dealers/showDealer";
    }

    @RequestMapping(value="/beforeDel")
    @ResponseBody
    public String beforeDel(HttpServletRequest request, HttpServletResponse response, String dealerId) throws Exception {
        String result = dealerCanDel(dealerId);
        if (result != null) {
            return result;
        } else {
            return "success";
        }
    }

    @RequestMapping(value = "/changePwd", method = RequestMethod.GET)
    public String changePwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return "WEB-INF/dealer/pwd";
    }

    @RequestMapping(value = "/newPassword" ,method = RequestMethod.POST)
    @ResponseBody
    public boolean newPassword(HttpServletRequest request, HttpServletResponse response, String oldPwd, String newPwd) throws Exception {
        return dealerService.savePassword(request, oldPwd, newPwd);
    }

    /**
     * 删除部门(不分页)
     * @param request
     * @param response
     * @param page
     * @param dealerBean
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/delDealer")
    public String delDealer(HttpServletRequest request, HttpServletResponse response, Page<DealerBean> page, DealerBean dealerBean, String[] dealerIds, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (dealerIds == null) {
            return removeDealer(request, response, page, dealerBean);
        } else {
            return removeDealer(request, response, page, dealerBean, dealerIds);
        }
    }

    /**
     * 检查部门是否可以被删除
     * @param dealerId
     * @throws Exception
     */
    private String dealerCanDel(String dealerId) throws Exception {
        DealerBean result = cacheUtils.getDealerCache().getObject(dealerId);
        if (result == null || result.getState() != SystemConst.STATE_DEFAULT) {
            return ErrorMsgConst.NO_USER;
        }
        return null;
    }

    private String removeDealer(HttpServletRequest request, HttpServletResponse response, Page<DealerBean> page, DealerBean dealerBean) throws Exception {
        String result = beforeDel(request, response, dealerBean.getDealerId());
        if (result.equals("success")) {
//			deptAttrService.delDeptAttrByDeptId(deptVo.getDeptId());
            dealerBean.setState(SystemConst.STATE_DELETE);
            LogicUtil.getInstance().saveParamsBeforeDelete(dealerBean, request);
            dealerService.removeDealerById(dealerBean);
            cacheUtils.getDealerCache().refreshCache(dealerBean.getDealerId());
            return showDealer(request, response, page);
        } else {
            request.setAttribute("errorCode", result);
            return showDealer(request, response, page);
        }
    }

    private String removeDealer(HttpServletRequest request, HttpServletResponse response, Page<DealerBean> page, DealerBean dealerBean, String[] dealerIds) throws Exception {
        for (String dealerId : dealerIds) {
            String result = beforeDel(request, response, dealerId);
            if (!result.equals("success")) {
                request.setAttribute("errorCode", result);
                return showDealer(request, response, page);
            }
        }
        DealerVo dealerVo = new DealerVo();
        LogicUtil.getInstance().saveParamsBeforeDelete(dealerVo, request);
        dealerVo.setDealerIds(dealerIds);
        dealerService.removeDealersById(dealerVo);
        for (String dealerId : dealerIds) {
            cacheUtils.getDealerCache().refreshCache(dealerId);
        }
        return showDealer(request, response, page);
    }

    @RequestMapping("/initpwd")
    @ResponseBody
    public String initpwd(HttpServletRequest request, HttpServletResponse response, DealerBean dealerBean) throws Exception {
        LogicUtil.getInstance().saveParamsBeforeUpdate(dealerBean, request);
        String dealerId = dealerBean.getDealerId();
        DealerBean result = dealerService.findDealerById(dealerId);
        if (result == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_USER, null, ErrorMsgConst.NO_USER);
        }
        String newRadomNum = StringUtil.getRandomNumericString(6);
        dealerBean.setPwd(StringUtil.MD5(StringUtil.MD5(newRadomNum, "UTF-8") + result.getSalt(), "UTF-8"));
        LogicUtil.getInstance().saveParamsBeforeUpdate(dealerBean, request);
        dealerService.updatePwd(dealerBean);
        cacheUtils.getDealerCache().refreshCache(dealerId);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, newRadomNum, null);
    }

}
