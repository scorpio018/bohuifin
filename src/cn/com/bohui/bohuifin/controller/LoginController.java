package cn.com.bohui.bohuifin.controller;

import cn.com.bohui.bohuifin.bean.AuthorityBean;
import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.ManagerBean;
import cn.com.bohui.bohuifin.bean.UsersBean;
import cn.com.bohui.bohuifin.bean.vo.AuthorityMenuVo;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.ParamConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.enums.EnumAuthGroup;
import cn.com.bohui.bohuifin.enums.EnumMenu;
import cn.com.bohui.bohuifin.service.authority.AuthorityService;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.manager.ManagerService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.service.users.UsersService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.util.zz.StringUtil;
import java.awt.image.BufferedImage;
import java.util.*;

/**
 * Created by Administrator on 2017/4/27 0027.
 */

@Controller
@RequestMapping(value = "/login")
public class LoginController {

    @Resource
    private UsersService usersService;

    @Resource
    private ManagerService managerService;

    @Resource
    private DealerService dealerService;

    @Resource
    private AuthorityService authorityService;

    @Resource
    private Producer captchaProducer;

    @Resource
    private SequencesService sequencesService;

    @RequestMapping(value = "/userLogin")
    public String toUserLogin(HttpServletRequest request, HttpServletResponse response, String act) throws Exception {
        request.setAttribute("act", act);
        return "login/Login";
    }

    @RequestMapping(value = "/adminLogin")
    public String toAdminLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return "WEB-INF/login/Login";
    }

    @RequestMapping(value = "/managerLogin", method = RequestMethod.POST)
    public String managerLogin(HttpServletRequest request, ManagerBean managerBean, String imageCode) throws Exception {
        request.setAttribute("userName", managerBean.getManagerName());
        request.setAttribute("pwd", managerBean.getPwd());
        String result = valcodeCheck(request, imageCode);
        if (result != null) {
            return result;
        }
        if (StringUtil.isEmpty(managerBean.getManagerName()) || StringUtil.isEmpty(managerBean.getPwd())) {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名和密码不能为空");
            request.setAttribute(ParamConst.LOGIN_TYPE, 1);
            return "WEB-INF/login/Login";
        }
        managerBean.setState(SystemConst.STATE_DEFAULT);
//        boolean isLogin = usersService.isLogin(usersBean, request.getSession());
        boolean isLogin = managerService.isLogin(managerBean, request.getSession());
        if (isLogin) {
            initAuthorityMenu(EnumAuthGroup.MANAGER.value(), request);
            return "redirect:" + SystemConst.BASE_PATH + "admin/users/showUser";
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名或密码错误");
            request.setAttribute(ParamConst.LOGIN_TYPE, 1);
            return "WEB-INF/login/Login";
        }
    }

    @RequestMapping(value = "/dealerLogin", method = RequestMethod.POST)
    public String dealerLogin(HttpServletRequest request, DealerBean dealerBean, String imageCode) throws Exception {
        request.setAttribute("userName", dealerBean.getDealerName());
        request.setAttribute("pwd", dealerBean.getPwd());
        String result = valcodeCheck(request, imageCode);
        if (result != null) {
            return result;
        }
        if (StringUtil.isEmpty(dealerBean.getDealerName()) || StringUtil.isEmpty(dealerBean.getPwd())) {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名和密码不能为空");
            request.setAttribute(ParamConst.LOGIN_TYPE, 2);
            return "WEB-INF/login/Login";
        }
        dealerBean.setState(SystemConst.STATE_DEFAULT);
//        boolean isLogin = usersService.isLogin(usersBean, request.getSession());
        boolean isLogin = dealerService.isLogin(dealerBean, request.getSession());
        if (isLogin) {
            initAuthorityMenu(EnumAuthGroup.DEALER.value(), request);
            return "redirect:" + SystemConst.BASE_PATH + "admin/products/showProduct";
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名或密码错误");
            request.setAttribute(ParamConst.LOGIN_TYPE, 2);
            return "WEB-INF/login/Login";
        }
    }

    @RequestMapping(value = "/userLogin", method = RequestMethod.POST)
    public String userLogin(HttpServletRequest request, UsersBean usersBean, String imageCode) throws Exception {
        request.setAttribute("act", "login");
        String result = valcodeCheck(request, imageCode);
        if (result != null) {
            return "login/Login";
        }
        if (StringUtil.isEmpty(usersBean.getUserName()) || StringUtil.isEmpty(usersBean.getPwd())) {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名和密码不能为空");
            return "login/Login";
        }
        usersBean.setState(SystemConst.STATE_DEFAULT);
        boolean isLogin = usersService.isLogin(usersBean, request.getSession());
        if (isLogin) {
            initAuthorityMenu(EnumAuthGroup.USER.value(), request);
            return "redirect:" + SystemConst.BASE_PATH + "index.jsp";
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名或密码错误");
            return "login/Login";
        }
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST)
    public String registerUser(HttpServletRequest request, HttpServletResponse response, UsersBean usersBean) throws Exception {
        if (StringUtil.isEmpty(usersBean.getUserName()) || StringUtil.isEmpty(usersBean.getPwd())) {
            request.setAttribute(ParamConst.ERROR_MSG, "用户名和密码不能为空");
            return "login/Login";
        }
        usersBean.setUserId(sequencesService.getId());
        usersBean.setAuthorityGroupId(EnumAuthGroup.USER.value());
        LogicUtil.getInstance().saveParamsBeforeInsert(usersBean, request);
        Tools.setUserSaltAndPassword(usersBean, usersBean.getPwd());
        usersBean.setState(SystemConst.STATE_DEFAULT);
        usersService.saveUsers(usersBean);
        return "WEB-INF/view/index";
    }

    private String valcodeCheck(HttpServletRequest request, String imageCode) throws Exception {
        if (StringUtil.isEmpty(imageCode)) {
            request.setAttribute(ParamConst.ERROR_MSG, "请填写验证码");
            return "WEB-INF/login/Login";
        }
        if (!imageCode.equalsIgnoreCase((String) request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY))) {
            request.setAttribute(ParamConst.ERROR_MSG, "验证码填写不正确");
            return "WEB-INF/login/Login";
        }
        return null;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.removeAttribute(ParamConst.USER_LOGIN);
        session.removeAttribute(ParamConst.MANAGER_LOGIN);
        session.removeAttribute(ParamConst.DEALER_LOGIN);
        session.removeAttribute(ParamConst.MENU_BEANS);
        session.removeAttribute(ParamConst.AUTHORITY_BEANS);
        return toAdminLogin(request, response);
    }

    @RequestMapping(value = "/identifyingCode", method = RequestMethod.GET)
    public void showIdentifyingCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String refer = request.getHeader("Referer");
//		if(refer== null || !refer.startsWith(SystemConst.BASE_PATH)){
//			response.sendError(404);
//		}
        if (refer == null) {
            response.sendError(404);
        }
        HttpSession session = request.getSession();
        response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        // Set standard HTTP/1.0 no-cache header.
        response.setHeader("Pragma", "no-cache");
        // return a jpeg
        response.setContentType("image/jpeg");
        // create the text for the image
        String capText = captchaProducer.createText();
        // store the text in the session
        session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
        // create the image with the text
        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        // write the data out
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
    }

    private void initAuthorityMenu(int authorityGroupId, HttpServletRequest request) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("authorityGroupId", authorityGroupId);
        params.put("state", SystemConst.STATE_DEFAULT);
        List<AuthorityBean> authorityBeans = authorityService.listAuthorityByAuthorityGroupId(params);
        Map<Integer, AuthorityMenuVo> menuVoMap = new LinkedHashMap<>();
        for (AuthorityBean bean : authorityBeans) {
            if (bean.getIsMenu().equals(EnumMenu.IS_MENU.value())) {
                AuthorityMenuVo vo = new AuthorityMenuVo();
                vo.setAuthorityBean(bean);
                vo.setAuthorityMenuVoList(new ArrayList<>());
                int parentAuthorityId = bean.getParentAuthorityId();
                if (menuVoMap.containsKey(parentAuthorityId)) {
                    AuthorityMenuVo authorityMenuVo = menuVoMap.get(parentAuthorityId);
                    List<AuthorityMenuVo> authorityMenuVoList = authorityMenuVo.getAuthorityMenuVoList();
                    authorityMenuVoList.add(vo);
                } else {
                    menuVoMap.put(bean.getAuthorityId(), vo);
                }
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute(ParamConst.MENU_BEANS, new ArrayList(menuVoMap.values()));
        session.setAttribute(ParamConst.AUTHORITY_BEANS, authorityBeans);
    }

}
