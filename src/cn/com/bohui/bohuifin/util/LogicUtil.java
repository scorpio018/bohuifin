package cn.com.bohui.bohuifin.util;

import cn.com.bohui.bohuifin.bean.*;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.JsonCodeConst;
import cn.com.bohui.bohuifin.consts.ParamConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Created by yangyang on 2017/6/27 0027.
 */
public class LogicUtil {

    private static LogicUtil logicUtil;

    private LogicUtil() {}

    public static LogicUtil getInstance() {
        if (logicUtil == null) {
            logicUtil = new LogicUtil();
        }
        return logicUtil;
    }

    public boolean checkIsLogin(BaseUserBean resultBean, BaseUserBean bean, String saveSessionType, HttpSession session) throws Exception {
        if (resultBean != null) {
            if (resultBean.getPwd().equals(Tools.encodePassword(bean.getPwd(), resultBean.getSalt()))) {
                session.setAttribute(saveSessionType, resultBean);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public String initResultJson(int code, String resultMsg, String errorMsg) throws Exception {
        JsonObject jo = new JsonObject();
        jo.addProperty("code", code);
        if (code == JsonCodeConst.CODE_SUCCESS) {
            jo.addProperty("resultMsg", resultMsg);
            jo.addProperty("errorMsg", "");
        } else {
            jo.addProperty("resultMsg", "");
            jo.addProperty("errorMsg", errorMsg);
        }
        return jo.toString();
    }

    public void saveMenu(HttpServletRequest request,String menuName) {
        request.getSession().setAttribute("menuName", menuName);
    }

    public void saveParamsBeforeInsert(BaseBean baseBean, HttpServletRequest request) throws Exception {
        String createBy = getCurLoginAccountId(request.getSession());
        baseBean.setCreateBy(createBy);
        baseBean.setCreateTime(new Timestamp(new Date().getTime()));
        baseBean.setState(SystemConst.STATE_DEFAULT);
    }

    public void saveParamsBeforeUpdate(BaseBean baseBean, HttpServletRequest request) throws Exception {
        String createBy = getCurLoginAccountId(request.getSession());
        baseBean.setUpdateBy(createBy);
        baseBean.setUpdateTime(new Timestamp(new Date().getTime()));
    }

    public void saveParamsBeforeDelete(BaseBean basebean, HttpServletRequest request) throws Exception {
        ManagerBean curLoginManagerBean = getCurLoginManagerBean(request.getSession());
        basebean.setUpdateBy(curLoginManagerBean.getManagerId());
        basebean.setUpdateTime(new Timestamp(new Date().getTime()));
        basebean.setState(SystemConst.STATE_DELETE);
    }

    public String getCurLoginAccountId(HttpSession session) throws Exception {
        ManagerBean curLoginManagerBean = getCurLoginManagerBean(session);
        if (curLoginManagerBean == null) {
            DealerBean curLoginDealerBean = getCurLoginDealerBean(session);
            if (curLoginDealerBean == null) {
                UsersBean curLoginUsersBean = getCurLoginUsersBean(session);
                if (curLoginUsersBean == null) {
                    throw new Exception(ErrorMsgConst.UNKNOWN_ERROR);
                } else {
                    return curLoginUsersBean.getUserId();
                }
            } else {
                return curLoginDealerBean.getDealerId();
            }
        } else {
            return curLoginManagerBean.getManagerId();
        }
    }

    public ManagerBean getCurLoginManagerBean(HttpSession session) throws Exception {
        ManagerBean managerBean = (ManagerBean) session.getAttribute(ParamConst.MANAGER_LOGIN);
        return managerBean;
    }

    public DealerBean getCurLoginDealerBean(HttpSession session) throws Exception {
        DealerBean dealerBean = (DealerBean) session.getAttribute(ParamConst.DEALER_LOGIN);
        return dealerBean;
    }

    public UsersBean getCurLoginUsersBean(HttpSession session) throws Exception {
        UsersBean usersBean = (UsersBean) session.getAttribute(ParamConst.USER_LOGIN);
        return usersBean;
    }

}
