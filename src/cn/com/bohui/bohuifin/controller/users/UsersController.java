package cn.com.bohui.bohuifin.controller.users;

import cn.com.bohui.bohuifin.enums.EnumAuthGroup;
import cn.com.bohui.bohuifin.bean.ManagerBean;
import cn.com.bohui.bohuifin.bean.Page;
import cn.com.bohui.bohuifin.bean.UsersBean;
import cn.com.bohui.bohuifin.bean.vo.UsersVo;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.*;
import cn.com.bohui.bohuifin.service.authority_group.AuthorityGroupService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.service.users.UsersService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.util.zz.StringUtil;
import java.util.*;

/**
 * Created by Administrator on 2017/5/2 0002.
 */
@Controller
public class UsersController {

    @Resource
    private UsersService usersService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @Resource
    private AuthorityGroupService authorityGroupService;

    @RequestMapping("/admin/users/showUser")
    public String showUser(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page) throws Exception {
        request.setAttribute("page", page);
//        loginService.saveMenu(request, "menu-user");
        return "WEB-INF/user/showUser";
    }

    @RequestMapping(value = "/admin/users/userData")
    @ResponseBody
    public Page<UsersBean> getUserData(HttpServletRequest request, HttpServletResponse response, String keyword, UsersBean usersBean, Page<UsersBean> page) throws Exception {
        List<UsersBean> result;
        if (usersBean == null) {
            usersBean = new UsersBean();
        }
        usersBean.setState(SystemConst.STATE_DEFAULT);
        page.setVo(usersBean);
        if (!StringUtil.isEmpty(keyword)) {
            page.getParams().put("keyword", "%" + Tools.DLEC(keyword) + "%");
        }
        result = usersService.listUsersByPage(page);
        page.setResults(result);
        return page;
    }

    @RequestMapping("/admin/users/showAddUser")
    public String addUserBegin(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page, UsersBean user, String act, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (ParamConst.ACT_ADD.equals(act)) {
            user.setUserId(sequencesService.getId());
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            UsersBean result = usersService.findUserById(user.getUserId());
            if (result == null) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.NO_USER);
                return showUser(request, response, page);
            }
            user = result;
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.UNKNOWN_ERROR);
            return showUser(request, response, page);
        }
        request.setAttribute("user", user);
        request.setAttribute("act", act);
        return "WEB-INF/user/addUser";
    }

    @RequestMapping(value = "/admin/users/saveUser", method = RequestMethod.POST)
    public String saveUser(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page, UsersBean user, String act, String keyword) throws Exception {
        boolean flag = checkParamsIsIntegrity4Insert(user);
        if (!flag) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.LACK_OF_PARAM);
            return addUserBegin(request, response, page, user, act, keyword);
        }
        // 去掉用户名中的前后空格
        user.setUserName(user.getUserName().trim());
        user.setAuthorityGroupId(EnumAuthGroup.USER.value());
        boolean isUserExists = usersService.checkUserExist(user.getUserId(), user.getUserName(), user.getAuthorityGroupId());
        if (isUserExists) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.USER_EXIST);
            return addUserBegin(request, response, page, user, act, keyword);
        }
        if (ParamConst.ACT_ADD.equals(act)) {
            user.setUserId(sequencesService.getId());
            user.setAuthorityGroupId(EnumAuthGroup.USER.value());
            LogicUtil.getInstance().saveParamsBeforeInsert(user, request);
            Tools.setUserSaltAndPassword(user, user.getPwd());
            usersService.saveUsers(user);
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            LogicUtil.getInstance().saveParamsBeforeUpdate(user, request);
            usersService.updateUser(user);
        }
        cacheUtils.getUserCache().refreshCache(user.getUserId());
        return "redirect:" + SystemConst.BASE_PATH + "users/showUser";
    }

    @RequestMapping(value="/admin/users/beforeDel")
    @ResponseBody
    public String beforeDel(HttpServletRequest request, HttpServletResponse response, String userId) throws Exception {
        String result = userCanDel(userId);
        if (result != null) {
            return result;
        } else {
            return "success";
        }
    }

    @RequestMapping(value = "/users/regist", method = RequestMethod.POST)
    public String register(HttpServletRequest request, HttpServletResponse response, UsersBean usersBean) throws Exception {
        boolean flag = checkParamsIsIntegrity4Insert(usersBean);
        if (!flag) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.LACK_OF_PARAM);
            request.setAttribute("act", "regist");
            return "login/Login";
        }
        return "WEB-INF/view/index";
    }

    /**
     * 删除部门(不分页)
     * @param request
     * @param response
     * @param page
     * @param usersBean
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/users/delUser")
    public String delUser(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page, UsersBean usersBean, String[] userIds, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (userIds == null) {
            return removeUser(request, response, page, usersBean);
        } else {
            return removeUsers(request, response, page, usersBean, userIds);
        }
    }

    /**
     * 添加用户时判断数据是否完整
     * @param usersBean
     * @return
     * @throws Exception
     */
    private boolean checkParamsIsIntegrity4Insert(UsersBean usersBean) throws Exception {
        if (StringUtil.isEmpty(usersBean.getUserName())) {
            return false;
        }
        if (StringUtil.isEmpty(usersBean.getPwd())) {
            return false;
        }
        if (StringUtil.isEmpty(usersBean.getNickName())) {
            return false;
        }
        if (StringUtil.isEmpty(usersBean.getTrueName())) {
            return false;
        }
        return true;
    }

    /**
     * 检查部门是否可以被删除
     * @param userId
     * @throws Exception
     */
    private String userCanDel(String userId) throws Exception {
        UsersBean result = cacheUtils.getUserCache().getObject(userId);
        if (result == null || result.getState() != SystemConst.STATE_DEFAULT) {
            return ErrorMsgConst.NO_USER;
        }
        return null;
    }

    private String removeUser(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page, UsersBean usersBean) throws Exception {
        String result = beforeDel(request, response, usersBean.getUserId());
        if (result.equals("success")) {
//			deptAttrService.delDeptAttrByDeptId(deptVo.getDeptId());
            usersBean.setState(SystemConst.STATE_DELETE);
            LogicUtil.getInstance().saveParamsBeforeDelete(usersBean, request);
            usersService.removeUserById(usersBean);
            cacheUtils.getUserCache().refreshCache(usersBean.getUserId());
            return showUser(request, response, page);
        } else {
            request.setAttribute("errorCode", result);
            return showUser(request, response, page);
        }
    }

    private String removeUsers(HttpServletRequest request, HttpServletResponse response, Page<UsersBean> page, UsersBean usersBean, String[] userIds) throws Exception {
        for (String userId : userIds) {
            String result = beforeDel(request, response, userId);
            if (!result.equals("success")) {
                request.setAttribute("errorCode", result);
                return showUser(request, response, page);
            }
        }
        UsersVo usersVo = new UsersVo();
        LogicUtil.getInstance().saveParamsBeforeDelete(usersVo, request);
        usersVo.setUserIds(userIds);
        usersService.removeUsersById(usersVo);
        for (String userId : userIds) {
            cacheUtils.getUserCache().refreshCache(userId);
        }
        return showUser(request, response, page);
    }

    @RequestMapping("/admin/users/initpwd")
    @ResponseBody
    public String initpwd(HttpServletRequest request, HttpServletResponse response, UsersBean usersBean) throws Exception {
        ManagerBean curUser = (ManagerBean) request.getSession().getAttribute(ParamConst.MANAGER_LOGIN);
        String userId = usersBean.getUserId();
        UsersBean result = usersService.findUserById(userId);
        if (result == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_USER, null, ErrorMsgConst.NO_USER);
        }
        String newRadomNum = StringUtil.getRandomNumericString(6);
        usersBean.setPwd(StringUtil.MD5(StringUtil.MD5(newRadomNum, "UTF-8") + result.getSalt(), "UTF-8"));
        LogicUtil.getInstance().saveParamsBeforeUpdate(usersBean, request);
        usersService.updatePwd(usersBean);
        cacheUtils.getUserCache().refreshCache(userId);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, newRadomNum, null);
    }

}
