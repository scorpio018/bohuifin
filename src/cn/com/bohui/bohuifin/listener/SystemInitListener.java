package cn.com.bohui.bohuifin.listener;

import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.SystemConst;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

public class SystemInitListener extends HttpServlet implements
		ServletContextListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(SystemInitListener.class);

	public void contextInitialized(ServletContextEvent sce) {
		logger.info("--------------------------------------");
		ServletContext servletContext = sce.getServletContext();
		
		// 读取main.properties文件中系统参数
		try {
			Tools.loadSysParam(servletContext);
		} catch (Exception e1) {
			logger.fatal(e1.getMessage(), e1);
		} 

		logger.info(SystemConst.SYSTEM_NAME + " 启动时间:" + Tools.formatDatetime(new java.util.Date()));
		logger.info("--------------------------------------");

	}

	public void contextDestroyed(ServletContextEvent sce) {
		logger.info("--------------------------------------");
		logger.info(SystemConst.SYSTEM_NAME + " 已经关闭");
		logger.info("关闭时间:" + Tools.formatDatetime(new java.util.Date()));
		logger.info("--------------------------------------");
	}

}
