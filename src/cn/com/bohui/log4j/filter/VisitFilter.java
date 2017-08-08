package cn.com.bohui.log4j.filter;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

public class VisitFilter implements Filter {
	
	private static Logger logger = Logger.getLogger(VisitFilter.class.getName());
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
	
	private String seperate = " ### ";
	
	private String[] ignoreRequestKey = {"password", "pwd", "pass", "passwd"};

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("Time:" + sdf.format(new Date()) + seperate);
		strBuf.append(getSessionId(request) + seperate);
		strBuf.append("Visit url:" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + request.getServletPath() + seperate);
		strBuf.append("Referer:" + request.getHeader("Referer") + seperate);
		strBuf.append("UserAgent:" + request.getHeader("user-agent") + seperate);
		strBuf.append("IP:" + getIp(request) + seperate);
		strBuf.append("User:" + getUserInfo(request) + seperate);
		strBuf.append(getRequestInfo(request) + seperate);
//		strBuf.append(getSessionInfo(request) + seperate);
		strBuf.append(getCookieInfo(request));
		logger.info(strBuf.toString());
		chain.doFilter(servletRequest, servletResponse);
//		logVo.setContextPath(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + request.getServletPath());
	}
	
	private String getUserInfo(HttpServletRequest request) {
		return null;
	}
	
	private String getRequestInfo(HttpServletRequest request) {
//		Enumeration<String> attributeNames = request.getAttributeNames();
		Enumeration<String> attributeNames = request.getParameterNames();
		StringBuffer requestInfos = new StringBuffer();
		requestInfos.append("Request:");
		while (attributeNames.hasMoreElements()) {
			String name = (String) attributeNames.nextElement();
			for (String ignore : ignoreRequestKey) {
				if (name.equalsIgnoreCase(ignore)) {
					continue;
				}
			}
			String value = request.getParameter(name);
			if (null != value && !"".equals(value)) {
				try {
					value = URLEncoder.encode(value, "GBK");
				} catch (UnsupportedEncodingException e) {
					logger.info("name为【" + name + "】的值encode异常");
					e.printStackTrace();
				}
				if (value.length() > 500) {
					requestInfos.append("{" + name + "=" + value.substring(0, 500) + "}");
				} else {
					requestInfos.append("{" + name + "=" + value + "}");
				}
			}
		}
		return requestInfos.toString();
	}
	
	/*private String getSessionInfo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Enumeration<String> attributeNames = session.getAttributeNames();
		StringBuffer sessionInfos = new StringBuffer();
		sessionInfos.append("Session:");
		while (attributeNames.hasMoreElements()) {
			String name = attributeNames.nextElement();
			String value = session.getAttribute(name).toString();
			sessionInfos.append("{" + name + "=" + value + "}");
		}
		return sessionInfos.toString();
	}*/
	
	private String getSessionId(HttpServletRequest request) {
		return "SessionId:" + request.getSession().getId();
	}
	
	private String getCookieInfo(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		StringBuffer cookieInfos = new StringBuffer();
		cookieInfos.append("Cookies:");
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				cookieInfos.append("{"+cookie.getName()+"="+cookie.getValue()+"}");
			}
		}
		return cookieInfos.toString();
	}
	
	private String getIp(HttpServletRequest request) {
		String realip = request.getHeader("X-Real-IP");
		if (null == realip || "".equals(realip)) {
			realip = request.getHeader("X-Forwarded-For");
			if (null == realip || "".equals(realip)) {
				return request.getRemoteAddr();
			} else {
				return realip;
			}
		} else {
			return realip;
		}
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		
	}

}
