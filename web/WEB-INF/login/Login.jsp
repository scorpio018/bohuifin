<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=SystemConst.BASE_PATH%>">
    <title><%=SystemConst.SYSTEM_NAME %>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script src="<%=SystemConst.BASE_PATH%>js/jquery-1.11.2.js"></script>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/style.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/flavr/animate.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/flavr/flavr.css"/>
    <!--[if lt IE 9]>
    <style type="text/css">
        .browser-happy {
            position: fixed;
            left: 0px;
            right: 0px;
            top: 0px;
            bottom: 0px;
            width: 100%;
            height: 100%;
            z-index: 999;
            background-color: #24a6fa;
        }

        .content {
            text-align: center;
            color: #fff;
            font-size: 24px;
        }
    </style>
    <![endif]-->
    <script>
        $(document).ready(function () {
            $('#userName').focus();
        });

    </script>
</head>
<body class="login-layout" background="images/zfxxgk.jpg"
      style="background-repeat:no-repeat; background-position:center top;">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container" style="width:500px;">
                    <!--[if lt IE 9]>
                    <div class="browser-happy">
                        <div class="content">
                            <p><%=SystemConst.BASE_PATH %>不支持IE9及以下浏览器访问！</p>
                            <p>请更换更高版本的浏览器进行访问。</p>
                            <p>本系统支持的浏览器：</p>
                            <p>Firefox 5 以上</p>
                            <p>Google Chrome 14 以上</p>
                            <p>Opera 11 以上</p>
                            <p>Safari 5 以上</p>
                            <p>IE 9 以上</p>

                        </div>
                    </div>
                    <![endif]-->
                    <div style="height:70px;"></div>
                    <div style="margin-left:-300px; height:79px;"><!-- <img src="images/logo.png" /> --></div>
                    <div class="space-6"></div>
                    <div class="position-relative">
                        <div id="login-box" class="login-box visible widget-box no-border"
                             style="margin:60px 210px;background-color:transparent">
                            <div class="center">
                                <h1>
                                    <span class="white ziti"><%=SystemConst.SYSTEM_NAME%></span>
                                </h1>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="space-6"></div>
                                    <form method="post" action="" id="loginForm">
                                        <fieldset>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="text" class="form-control ziti"
                                                           placeholder="用户名" name="userName" id="userName" value="${requestScope.userName}"/>
                                                    <input type="hidden" name="managerName" id="managerName"/>
                                                    <input type="hidden" name="dealerName" id="dealerName"/>
                                                    <i class="icon-user"></i>
                                                </span>
                                            </label>

                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control ziti"
                                                           placeholder="密码" name="pwd" autocomplete="off"
                                                           id="pwd" onkeydown="showImg(event, '<%=SystemConst.BASE_PATH%>');" value="${requestScope.pwd}"/>
                                                    <input type="hidden" class="form-control ziti"
                                                           id="imageCodeHidd" name="imageCode"/>
                                                    <i class="icon-lock"></i>
                                                </span>
                                            </label>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <label for="gly">
                                                        <c:choose>
                                                            <c:when test="${requestScope.loginType eq 1}">
                                                                <input type="radio" class="" checked placeholder="登录角色"
                                                                       checked="checked"
                                                                       name="login_type" autocomplete="off" id="gly"
                                                                       value="1"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="radio" class="" checked placeholder="登录角色"
                                                                       name="login_type" autocomplete="off" id="gly"
                                                                       value="1"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        管理员登录
                                                    </label>

                                                    <label for="jyy">
                                                        <c:choose>
                                                            <c:when test="${requestScope.loginType eq 2}">
                                                                <input type="radio" class="" placeholder="登录角色" name="login_type" checked="checked"
                                                                       autocomplete="off" id="jyy" value="2"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="radio" class="" placeholder="登录角色" name="login_type"
                                                                       autocomplete="off" id="jyy" value="2"/>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        交易员登录
                                                    </label>
                                                    <i class="icon-lock"></i>
                                                </span>
                                            </label>
                                            <div class="clearfix">
                                                <button type="button"
                                                        class="width-100 pull-right btn btn-sm btn-primary"
                                                        onclick="showImgCode('<%=SystemConst.BASE_PATH%>');">
                                                    <h4 style="display:inline;" class="ziti">
                                                        <i class="icon-key"></i>
                                                        <span class="ziti">登录</span>
                                                    </h4>
                                                </button>
                                            </div>
                                            <div class="space-4"></div>
                                            <p style="text-align:center;color:red;" class="ziti">${error}</p>
                                        </fieldset>
                                    </form>
                                </div><!-- /widget-main -->

                                <%--<div class="toolbar" style="height:40px;margin:auto;text-align:center;">
                                    <p class="user-signup-link ziti" style="margin-top:10px;">当前IP：${ip}</p>
                                </div>--%>
                            </div><!-- /widget-body -->
                        </div><!-- /login-box -->
                    </div><!-- /widget-body -->
                </div><!-- /signup-box -->
            </div><!-- /position-relative -->
        </div>
    </div><!-- /.col -->
</div><!-- /.main-container -->

<!-- basic scripts -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>
<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='js/assets/js/jquery-1.10.2.min.js'>" + "<" + "/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/flavr/flavr.min.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/login/login.js"></script>
<!-- inline scripts related to this page -->

<script type="text/javascript">
    function enterSubmit(e) {
        if (e.keyCode == 13) {
            $("#imageCodeHidd").val($("#imageCode").val());
            var loginType = $("input[name='login_type']:checked").val();

            if (loginType == 1) {
                $("#managerName").val($("#userName").val());
                $("#loginForm").attr("action", "<%=SystemConst.BASE_PATH%>login/managerLogin");
            } else if (loginType == 2) {
                $("#dealerName").val($("#userName").val());
                $("#loginForm").attr("action", "<%=SystemConst.BASE_PATH%>login/dealerLogin");
            } else {
                return;
            }
            $("#loginForm").submit();
        }
    }
</script>
</body>
</html>
