package cn.com.bohui.bohuifin.controller.dealer;

import cn.com.bohui.bohuifin.bean.*;
import cn.com.bohui.bohuifin.bean.vo.DealerTalkVo;
import cn.com.bohui.bohuifin.bean.vo.DealerVo;
import cn.com.bohui.bohuifin.bean.vo.ProductVo;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.ParamConst;
import cn.com.bohui.bohuifin.consts.SeqConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.dealer_talk.DealerTalkService;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by scorpioyoung on 2017/8/9 0009.
 */
@Controller
@RequestMapping(value = "/admin/dealertalk")
public class DealerTalkController {

    @Resource
    private DealerTalkService dealerTalkService;

    @Resource
    private DealerService dealerService;

    @Resource
    private ProductService productService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @RequestMapping(value = "/showDealerTalk")
    public String showTalk(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page) throws Exception {
        request.setAttribute("page", page);
        return "WEB-INF/dealer/showDealerTalk";
    }

    @RequestMapping(value = "/dealerTalkData", method = RequestMethod.POST)
    @ResponseBody
    public Page<DealerTalkBean> dealerTalkData(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page,  DealerTalkBean dealerTalkBean) throws Exception {
        List<DealerTalkBean> result;
        if (dealerTalkBean == null) {
            dealerTalkBean = new DealerTalkBean();
        }
        dealerTalkBean.setState(SystemConst.STATE_DEFAULT);
        page.setVo(dealerTalkBean);
        result = dealerTalkService.listDealerTalkByPage(page);
        page.setResults(result);
        return page;
    }

    @RequestMapping(value = "/showAddDealerTalk", method = RequestMethod.POST)
    public String showAddDealerTalk(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page, DealerTalkBean dealerTalkBean, String act) throws Exception {
        initRefData(request);
        if (ParamConst.ACT_ADD.equals(act)) {
            dealerTalkBean.setTalkId(sequencesService.haveSeq(SeqConst.SEQ_DEALER_TALK_ID).intValue());
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            DealerTalkBean result = dealerTalkService.findDealerTalkById(dealerTalkBean.getTalkId());
            if (result == null) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.NO_USER);
                return showTalk(request, response, page);
            }
            dealerTalkBean = result;
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.UNKNOWN_ERROR);
            return showTalk(request, response, page);
        }
        request.setAttribute("dealerTalk", dealerTalkBean);
        request.setAttribute("act", act);
        return "WEB-INF/dealer/addDealerTalk";
    }

    @RequestMapping(value = "/saveDealerTalk", method = RequestMethod.POST)
    public String saveDealer(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page, DealerTalkBean dealerTalkBean, String act) throws Exception {
        String errorMsg = formValidate(dealerTalkBean.getTalkId(), dealerTalkBean.getDealerId(), dealerTalkBean.getProductId(), act);
        if (errorMsg != null) {
            request.setAttribute(ParamConst.ERROR_MSG, errorMsg);
            return showAddDealerTalk(request, response, page, dealerTalkBean, act);
        }
        if (ParamConst.ACT_ADD.equals(act)) {
            LogicUtil.getInstance().saveParamsBeforeInsert(dealerTalkBean, request);
            dealerTalkService.saveDealerTalk(dealerTalkBean);
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            LogicUtil.getInstance().saveParamsBeforeUpdate(dealerTalkBean, request);
            dealerTalkService.updateDealerTalk(dealerTalkBean);
        }
        cacheUtils.getDealerTalkBeanCache().refreshCache(dealerTalkBean.getTalkId());
        return "redirect:" + SystemConst.BASE_PATH + "dealertalk/showDealerTalk";
    }

    @RequestMapping(value="/beforeDel")
    @ResponseBody
    public String beforeDel(HttpServletRequest request, HttpServletResponse response, Integer talkId) throws Exception {
        String result = dealerTalkCanDel(talkId);
        if (result != null) {
            return result;
        } else {
            return "success";
        }
    }

    /**
     * 删除部门(不分页)
     * @param request
     * @param response
     * @param page
     * @param dealerTalkBean
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/delDealerTalk")
    public String delDealerTalk(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page, DealerTalkBean dealerTalkBean, Integer[] talkIds) throws Exception {
        if (talkIds == null) {
            return removeDealerTalk(request, response, page, dealerTalkBean);
        } else {
            return removeDealerTalk(request, response, page, dealerTalkBean, talkIds);
        }
    }

    private void initRefData(HttpServletRequest request) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("state", SystemConst.STATE_DEFAULT);
        ManagerBean curLoginManagerBean = LogicUtil.getInstance().getCurLoginManagerBean(request.getSession());
        // 只有管理员可以进行操作员筛选
        if (curLoginManagerBean == null) {
            DealerBean curLoginDealerBean = LogicUtil.getInstance().getCurLoginDealerBean(request.getSession());
            params.put("dealerId", curLoginDealerBean.getDealerId());
        }
        List<DealerVo> dealerVos = dealerService.listAllDealersJoinProducts(params);
        request.setAttribute("dealers", dealerVos);

        params.put("state", SystemConst.STATE_PASS);
        List<ProductVo> productVos = productService.listAllProducts(params);
        request.setAttribute("products", productVos);
    }

    /**
     * 检查宣言是否可以被删除
     * @param talkId
     * @throws Exception
     */
    private String dealerTalkCanDel(Integer talkId) throws Exception {
        DealerTalkBean result = cacheUtils.getDealerTalkBeanCache().getObject(talkId);
        if (result == null || result.getState() != SystemConst.STATE_DEFAULT) {
            return ErrorMsgConst.NO_TALK;
        }
        return null;
    }

    private String removeDealerTalk(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page, DealerTalkBean dealerTalkBean) throws Exception {
        String result = beforeDel(request, response, dealerTalkBean.getTalkId());
        if (result.equals("success")) {
            dealerTalkBean.setState(SystemConst.STATE_DELETE);
            LogicUtil.getInstance().saveParamsBeforeDelete(dealerTalkBean, request);
            dealerTalkService.removeDealerTalkById(dealerTalkBean);
            cacheUtils.getDealerTalkBeanCache().refreshCache(dealerTalkBean.getTalkId());
            return showTalk(request, response, page);
        } else {
            request.setAttribute("errorCode", result);
            return showTalk(request, response, page);
        }
    }

    private String removeDealerTalk(HttpServletRequest request, HttpServletResponse response, Page<DealerTalkBean> page, DealerTalkBean dealerTalkBean, Integer[] talkIds) throws Exception {
        for (Integer talkId : talkIds) {
            String result = beforeDel(request, response, talkId);
            if (!result.equals("success")) {
                request.setAttribute("errorCode", result);
                return showTalk(request, response, page);
            }
        }
        DealerTalkVo dealerVo = new DealerTalkVo();
        LogicUtil.getInstance().saveParamsBeforeDelete(dealerVo, request);
        dealerVo.setTalkIds(talkIds);
        dealerTalkService.removeDealerTalkByIds(dealerVo);
        for (Integer talkId : talkIds) {
            cacheUtils.getDealerTalkBeanCache().refreshCache(talkId);
        }
        return showTalk(request, response, page);
    }

    private String formValidate(int talkId, String dealerId, String productId, String act) throws Exception {
        if (ParamConst.ACT_UPDATE.equals(act)) {
            DealerTalkBean cacheDealerTalkBean = cacheUtils.getDealerTalkBeanCache().getObject(talkId);
            if (cacheDealerTalkBean == null) {
                return ErrorMsgConst.NO_TALK;
            }
        }
        DealerBean cacheDealerBean = cacheUtils.getDealerCache().getObject(dealerId);
        if (cacheDealerBean == null) {
            return ErrorMsgConst.NO_DEALER;
        }
        ProductBean cacheProductBean = cacheUtils.getProductCache().getObject(productId);
        if (cacheProductBean == null) {
            return ErrorMsgConst.NO_PRODUCT;
        }
        return null;
    }
}
