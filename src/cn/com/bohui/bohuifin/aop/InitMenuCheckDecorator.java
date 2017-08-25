package cn.com.bohui.bohuifin.aop;

import cn.com.bohui.bohuifin.util.LogicUtil;
import org.aspectj.lang.JoinPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class InitMenuCheckDecorator extends InitMenuCheckAspect {

    @Override
    public void saveMenu(JoinPoint jp, Object rvt) throws Exception {
        Object[] parames = jp.getArgs();//获取目标方法体参数
        HttpServletRequest request = (HttpServletRequest) parames[0];
        String requestURI = request.getRequestURI();
        if (requestURI.contains("/admin/users")) {
            LogicUtil.getInstance().saveMenu(request, "icon-user");
            return;
        } else if (requestURI.contains("/admin/managers")) {
            LogicUtil.getInstance().saveMenu(request, "icon-group");
            return;
        } else if (requestURI.contains("/admin/dealers")) {
            LogicUtil.getInstance().saveMenu(request, "icon-credit-card");
            return;
        } else if (requestURI.contains("/admin/products")) {
            LogicUtil.getInstance().saveMenu(request, "icon-certificate");
            return;
        } else if (requestURI.contains("/admin/dealertalk")) {
            LogicUtil.getInstance().saveMenu(request, "icon-comments");
        }
//        RequestMapping rm = (RequestMapping) jp.getSignature().getDeclaringType().getAnnotation(RequestMapping.class);
//        String[] value = rm.value();
//        for (String v : value) {
//
//        }
    }


//	@Resource
//	protected AccessLogService accessLogService;

//	@Resource
//	protected SeqService seqService;

//	@Resource
//	protected UserService userService;

//	@Override
//	public void saveLog(JoinPoint jp, Object rvt) throws Exception {
//		if (SysOption.ENABLE_ACCESS_LOG) {
//			Object[] parames = jp.getArgs();//获取目标方法体参数
//			HttpServletRequest request = (HttpServletRequest) parames[0];
//			AccessLogVo logVo = new AccessLogVo();
//			logVo.setContextPath(request.getServletPath());
//			logVo.setParams(request.getQueryString());
//			logVo.setIp(Tools.getIp(request));
//			logVo.setReferer(request.getHeader("Referer"));
//			logVo.setUserAgent(request.getHeader("user-agent"));
//			UserVo userVo = userService.getCurUserVo(request);
//			if (userVo == null) {
//				logVo.setUserId(-1);
//			} else {
//				logVo.setUserId(userVo.getUserId());
//				logVo.setUserName(userVo.getUserName());
//				logVo.setTrueName(userVo.getTruename());
//			}
//			accessLogService.insertLog(logVo);
//
//	        /*String signature = jp.getSignature().toString();//获取目标方法签名
//	        String methodName = signature.substring(signature.lastIndexOf(".")+1, signature.indexOf("("));*/
//		}
//	}

//	private String initUrlParams(HttpServletRequest request) throws Exception {
//		Enumeration<String> enu = request.getParameterNames();
//		StringBuffer strBuf = new StringBuffer();
//		while (enu.hasMoreElements()) {
//			String paramName=(String)enu.nextElement();
//			String paramValue = request.getParameter(paramName);
//			if (paramValue.length() >= 100) {
//				continue;
//			}
//			strBuf.append(paramName + "=" + paramValue + "&");
//		}
//		if (strBuf.length() == 0) {
//			return strBuf.toString();
//		} else {
//			if (strBuf.length() > 300) {
//				return strBuf.substring(0, 300);
//			} else {
//				return strBuf.substring(0, strBuf.length() - 1);
//			}
//		}
//	}

}
