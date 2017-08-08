<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title><%=SystemConst.SYSTEM_NAME %></title>
    
	<frameset rows="45,*" frameborder="no" border="0" framespacing="0">
		<!-- 顶部界面 -->
		<frame src="top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" class="topFrame" />
		<!-- 中间界面 -->
		<frameset rows="*" cols="190,*" frameborder="no" border="0" framespacing="0">
			<!-- 中间左界面 -->
			<frame src="left.jsp" name="leftFrame" scrolling="No" noresize id="leftFrame"/>
			<!-- 中间右界面 -->
			<frame src="jqGrid.jsp" name="mainFrame" id="mainFrame" />
		</frameset>
	</frameset>

  </head>
  
  <body>
  	
  </body>
</html>
