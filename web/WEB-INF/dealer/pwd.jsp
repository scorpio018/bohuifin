<%@page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=SystemConst.BASE_PATH%>">
    <title><%=SystemConst.SYSTEM_NAME%>
    </title>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/jquery-ui-1.10.3.full.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/style.css"/>
    <script src="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
</head>
<script type="text/javascript">

</script>
<body>
<c:choose>
    <c:when test="${sessionScope.dealerLogin==null}">
        <div style="display:inline;">
            无效的用户
        </div>
    </c:when>
    <c:otherwise>
        <label style="width:90px;">用户名：</label>
        <div style="display:inline;">${sessionScope.dealerLogin.dealerName}</div>
        <br>
        <div class="space-4">
            <div class="space-4"></div>
        </div>
        <label style="width:90px;">真实姓名：</label>
        <div style="display:inline;">${sessionScope.dealerLogin.trueName}</div>
        <br>
        <div class="space-4">
            <div class="space-4"></div>
        </div>
        <label style="width:90px;">当前密码：</label>
        <input type="password" id="form-field-1"><br>
        <div class="space-4">
            <div class="space-4"></div>
        </div>
        <label style="width:90px;">新密码：</label>
        <input type="password" id="form-field-2"><br>
        <div class="space-4">
            <div class="space-4"></div>
        </div>
        <label style="width:90px;">新密码确认：</label>
        <input type="password" id="form-field-3"><br>
    </c:otherwise>
</c:choose>
</body>
</html>
