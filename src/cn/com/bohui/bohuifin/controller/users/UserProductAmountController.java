package cn.com.bohui.bohuifin.controller.users;

import cn.com.bohui.bohuifin.bean.UserProductAmountBean;
import cn.com.bohui.bohuifin.bean.UsersBean;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.JsonCodeConst;
import cn.com.bohui.bohuifin.service.user_accounts.UserAccountsService;
import cn.com.bohui.bohuifin.service.user_product_amount.UserProductAmountService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by scorpioyoung on 2017/8/8 0008.
 */
@Controller
@RequestMapping(value = "/user")
public class UserProductAmountController {

    @Resource
    private UserAccountsService userAccountsService;

    @Resource
    private UserProductAmountService userProductAmountService;

    @Resource
    private CacheUtils cacheUtils;

    @RequestMapping(value = "/investProduct", method = RequestMethod.POST)
    @ResponseBody
    public String investProduct(HttpServletRequest request, HttpServletResponse response, UserProductAmountBean userProductAmountBean) throws Exception {
        int code = userProductAmountService.productInvestment(userProductAmountBean.getUserId(), userProductAmountBean.getProductId(), userProductAmountBean.getAmount());
        if (code == JsonCodeConst.CODE_ERROR_NO_USER) {
            return LogicUtil.getInstance().initResultJson(code, null, ErrorMsgConst.NO_USER);
        } else if (code == JsonCodeConst.CODE_ERROR_NO_PRODUCT) {
            return LogicUtil.getInstance().initResultJson(code, null, ErrorMsgConst.NO_PRODUCT);
        } else if (code == JsonCodeConst.CODE_INVEST_ACCOUNT_IS_GATHER_THAN_INVESTABLE_ACCOUNT) {
            return LogicUtil.getInstance().initResultJson(code, null, ErrorMsgConst.INVEST_ACCOUNT_IS_GATHER_THAN_INVESTABLE_ACCOUNT);
        } else if (code == JsonCodeConst.CODE_USER_ACCOUNT_NOT_ENOUGH) {
            return LogicUtil.getInstance().initResultJson(code, null, ErrorMsgConst.USER_ACCOUNT_NOT_ENOUGH);
        }
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, null, null);
    }

    @RequestMapping(value = "/checkingAccount", method = RequestMethod.POST)
    @ResponseBody
    public String checkingAccount(HttpServletRequest request, HttpServletResponse response, String userId) throws Exception {
        UsersBean cacheUserBean = cacheUtils.getUserCache().getObject(userId);
        if (cacheUserBean == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_USER, null, ErrorMsgConst.NO_USER);
        }
        double userAccounts = userAccountsService.findUserAccounts(userId);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, String.valueOf(userAccounts), null);
    }
}
