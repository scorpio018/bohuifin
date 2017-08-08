package cn.com.bohui.bohuifin.interceptor;

import cn.com.bohui.bohuifin.bean.AuthorityBean;
import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.ManagerBean;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.ParamConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {

    public String[] allowUrls;//还没发现可以直接配置不拦截的资源，所以在代码里面来排除

    public String norolePage;

    public void setAllowUrls(String[] allowUrls) {
        this.allowUrls = allowUrls;
    }

    public void setNorolePage(String norolePage) {
        this.norolePage = norolePage;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        // 获取当前拦截的路径
        String requestUrl = request.getRequestURI().replace(request.getContextPath(), "");
        if (null != allowUrls && allowUrls.length >= 1) {
            for (String url : allowUrls) {
                if (requestUrl.contains(url)) {
                    return true;
                }
            }
        }
        HttpSession session = request.getSession();
        ManagerBean curLoginManagerBean = LogicUtil.getInstance().getCurLoginManagerBean(session);
        if (curLoginManagerBean == null) {
            DealerBean curLoginDealerBean = LogicUtil.getInstance().getCurLoginDealerBean(session);
            if (curLoginDealerBean == null) {
                response.sendRedirect(SystemConst.BASE_PATH + "login/adminLogin");
                return false;
                /*UsersBean curLoginUsersBean = LogicUtil.getInstance().getCurLoginUsersBean(session);
                if (curLoginUsersBean == null) {

                }*/
            }
        }
        boolean hasAuth = checkCurLoginAccountUrlAuth(requestUrl, session);
        if (!hasAuth) {
            response.sendRedirect(request.getContextPath() + norolePage);
        }
        //返回true，则这个方面调用后会接着调用postHandle(),  afterCompletion()
        return true;
    }


    private boolean checkCurLoginAccountUrlAuth(String requestUrl, HttpSession session) throws Exception {
        List<AuthorityBean> authorityBeans = (List<AuthorityBean>) session.getAttribute(ParamConst.AUTHORITY_BEANS);
        if (authorityBeans == null) {
            throw new Exception(ErrorMsgConst.NO_AUTH);
        }
        for (AuthorityBean bean : authorityBeans) {
            if (bean.getAuthorityUrl().contains(requestUrl)) {
                return true;
            }
        }
        return false;
    }
}
