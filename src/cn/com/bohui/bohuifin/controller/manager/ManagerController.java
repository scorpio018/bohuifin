package cn.com.bohui.bohuifin.controller.manager;

import cn.com.bohui.bohuifin.enums.EnumAuthGroup;
import cn.com.bohui.bohuifin.bean.ManagerBean;
import cn.com.bohui.bohuifin.bean.Page;
import cn.com.bohui.bohuifin.bean.vo.ManagerVo;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.*;
import cn.com.bohui.bohuifin.service.authority_group.AuthorityGroupService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.service.manager.ManagerService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.util.zz.StringUtil;
import java.util.List;

/**
 * Created by Administrator on 2017/5/2 0002.
 */
@Controller
@RequestMapping(value = "/admin/managers")
public class ManagerController {

    @Resource
    private ManagerService managerService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @Resource
    private AuthorityGroupService authorityGroupService;

    @RequestMapping("/showManager")
    public String showManager(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page) throws Exception {
        request.setAttribute("page", page);
//        loginService.saveMenu(request, "menu-manager");
        return "WEB-INF/manager/showManager";
    }

    @RequestMapping(value = "/managerData")
    @ResponseBody
    public Page<ManagerBean> getManagerData(HttpServletRequest request, HttpServletResponse response, String keyword, ManagerBean managerBean, Page<ManagerBean> page) throws Exception {
        List<ManagerBean> result;
        if (managerBean == null) {
            managerBean = new ManagerBean();
        }
        managerBean.setState(SystemConst.STATE_DEFAULT);
        page.setVo(managerBean);
        if (!StringUtil.isEmpty(keyword)) {
            page.getParams().put("keyword", "%" + Tools.DLEC(keyword) + "%");
        }
        result = managerService.listManagerByPage(page);
        page.setResults(result);
        return page;
    }

    @RequestMapping("/showAddManager")
    public String addManagerBegin(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page, ManagerBean manager, String act, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (ParamConst.ACT_ADD.equals(act)) {
            manager.setManagerId(sequencesService.getId());
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            ManagerBean result = managerService.findManagerById(manager.getManagerId());
            if (result == null) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.NO_USER);
                return showManager(request, response, page);
            }
            manager = result;
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.UNKNOWN_ERROR);
            return showManager(request, response, page);
        }
        request.setAttribute("manager", manager);
        request.setAttribute("act", act);
        return "WEB-INF/manager/addManager";
    }

    @RequestMapping(value = "/saveManager", method = RequestMethod.POST)
    public String saveManager(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page, ManagerBean manager, String act, String keyword) throws Exception {
        // 去掉管理员名中的前后空格
        manager.setManagerName(manager.getManagerName().trim());
        manager.setAuthorityGroupId(EnumAuthGroup.MANAGER.value());
        boolean isManagerExists = managerService.checkManagerExist(manager.getManagerId(), manager.getManagerName(), manager.getAuthorityGroupId());
        if (isManagerExists) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.USER_EXIST);
            return addManagerBegin(request, response, page, manager, act, keyword);
        }
        if (ParamConst.ACT_ADD.equals(act)) {
            manager.setManagerId(sequencesService.getId());
            manager.setAuthorityGroupId(EnumAuthGroup.MANAGER.value());
            LogicUtil.getInstance().saveParamsBeforeInsert(manager, request);
            Tools.setUserSaltAndPassword(manager, manager.getPwd());
            managerService.saveManager(manager);
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            LogicUtil.getInstance().saveParamsBeforeUpdate(manager, request);
            managerService.updateManager(manager);
        }
        cacheUtils.getManagerCache().refreshCache(manager.getManagerId());
        return "redirect:" + SystemConst.BASE_PATH + "admin/managers/showManager";
    }

    @RequestMapping(value="/beforeDel")
    @ResponseBody
    public String beforeDel(HttpServletRequest request, HttpServletResponse response, String managerId) throws Exception {
        String result = managerCanDel(managerId);
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
     * @param managerBean
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/delManager")
    public String delManager(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page, ManagerBean managerBean, String[] managerIds, String keyword) throws Exception {
        request.setAttribute("keyword", keyword);
        if (managerIds == null) {
            return removeManager(request, response, page, managerBean);
        } else {
            return removeManager(request, response, page, managerBean, managerIds);
        }
    }

    /**
     * 检查部门是否可以被删除
     * @param managerId
     * @throws Exception
     */
    private String managerCanDel(String managerId) throws Exception {
        ManagerBean result = cacheUtils.getManagerCache().getObject(managerId);
        if (result == null || result.getState() != SystemConst.STATE_DEFAULT) {
            return ErrorMsgConst.NO_USER;
        }
        return null;
    }

    private String removeManager(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page, ManagerBean managerBean) throws Exception {
        String result = beforeDel(request, response, managerBean.getManagerId());
        if (result.equals("success")) {
//			deptAttrService.delDeptAttrByDeptId(deptVo.getDeptId());
            managerBean.setState(SystemConst.STATE_DELETE);
            LogicUtil.getInstance().saveParamsBeforeDelete(managerBean, request);
            managerService.removeManagerById(managerBean);
            cacheUtils.getManagerCache().refreshCache(managerBean.getManagerId());
            return showManager(request, response, page);
        } else {
            request.setAttribute("errorCode", result);
            return showManager(request, response, page);
        }
    }

    private String removeManager(HttpServletRequest request, HttpServletResponse response, Page<ManagerBean> page, ManagerBean managerBean, String[] managerIds) throws Exception {
        for (String managerId : managerIds) {
            String result = beforeDel(request, response, managerId);
            if (!result.equals("success")) {
                request.setAttribute("errorCode", result);
                return showManager(request, response, page);
            }
        }
        ManagerVo managerVo = new ManagerVo();
        LogicUtil.getInstance().saveParamsBeforeDelete(managerVo, request);
        managerVo.setManagerIds(managerIds);
        managerService.removeManagersById(managerVo);
        for (String managerId : managerIds) {
            cacheUtils.getManagerCache().refreshCache(managerId);
        }
        return showManager(request, response, page);
    }

    @RequestMapping("/initpwd")
    @ResponseBody
    public String initpwd(HttpServletRequest request, HttpServletResponse response, ManagerBean managerBean) throws Exception {
        ManagerBean curManager = (ManagerBean) request.getSession().getAttribute(ParamConst.MANAGER_LOGIN);
        String managerId = managerBean.getManagerId();
        ManagerBean result = managerService.findManagerById(managerId);
        if (result == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_USER, null, ErrorMsgConst.NO_USER);
        }
        String newRadomNum = StringUtil.getRandomNumericString(6);
        managerBean.setPwd(StringUtil.MD5(StringUtil.MD5(newRadomNum, "UTF-8") + result.getSalt(), "UTF-8"));
        LogicUtil.getInstance().saveParamsBeforeUpdate(managerBean, request);
        managerService.updatePwd(managerBean);
        cacheUtils.getManagerCache().refreshCache(managerId);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, newRadomNum, null);
    }

}
