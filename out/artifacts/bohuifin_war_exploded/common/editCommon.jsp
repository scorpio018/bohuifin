<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE HTML>

<html>
  <head>
    <title>增加人员</title>
    <meta name="renderer" content="webkit">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/font-awesome.min.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/chosen.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/datepicker.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace.min.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/style.css" />
	<script src="<%=SystemConst.BASE_PATH%>js/jquery-1.11.2.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace-extra.min.js"></script>
	<script type="text/javascript">
		window.jQuery || document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>
	<script type="text/javascript">
		if("ontouchend" in document) document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
	</script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.validate.min.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/chosen.jquery.min.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/date-time/bootstrap-datepicker.min.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/date-time/bootstrap-datepicker.zh-CN.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/additional-methods.min.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace-elements.min.js"></script>
	<script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace.min.js"></script>
  	</head>
  
</html>
