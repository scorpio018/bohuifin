<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <title><%=SystemConst.SYSTEM_NAME%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="<%=SystemConst.BASE_PATH%>css/userLogin.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/flavr/animate.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/flavr/flavr.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.css"/>
    <script src="<%=SystemConst.BASE_PATH%>js/jquery-1.11.2.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/flavr/flavr.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.min.js"></script>
    <script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/login/login.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/common/hints.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            var error = "${requestScope.error}";
            if (error != "") {
                errorAlert(error);
            }
        })
        function enterSubmit(e) {
            if ((e != undefined && e.keyCode == 13) || e == undefined) {
                $("#imageCodeHidd").val($("#imageCode").val());
                $("#login_form").submit();
                console.log("enter:" + e);
            }
        }
    </script>
</head>
<body>
<h1>用户登录<sup>V2017</sup></h1>

<div class="login" style="margin-top:50px;">

    <div class="header">
        <c:choose>
            <c:when test="${requestScope.act eq 'login'}">
                <div class="switch" id="switch"><a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
                    <a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a><div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 70px; left: 0px;"></div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="switch" id="switch"><a class="switch_btn" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
                    <a class="switch_btn_focus" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a><div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 154px;"></div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
    <c:choose>
        <c:when test="${requestScope.act eq 'login'}">
            <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;"
        </c:when>
        <c:otherwise>
            <div class="web_qr_login" id="web_qr_login" style="display: none; height: 235px;"
        </c:otherwise>
    </c:choose>

        <!--登录-->
        <div class="web_login" id="web_login">


            <div class="login-box">


                <div class="login_form">
                    <form action="<%=SystemConst.BASE_PATH%>login/userLogin" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                        <input type="hidden" name="to" value="log"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips" for="u">帐号：</label>
                            <div class="inputOuter" id="uArea">

                                <input type="text" id="u" name="userName" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips" for="p">密码：</label>
                            <div class="inputOuter" id="pArea">

                                <input type="password" id="p" name="pwd" class="inputstyle" onkeydown="showImg(event, '<%=SystemConst.BASE_PATH%>');"/>
                                <input type="hidden" class="form-control ziti"
                                       id="imageCodeHidd" name="imageCode"/>
                            </div>
                        </div>

                        <div style="padding-left:50px;margin-top:20px;"><input type="buton" value="登 录" style="width:150px;" class="button_blue" onclick="showImgCode('<%=SystemConst.BASE_PATH%>');"/></div>
                    </form>
                </div>

            </div>

        </div>
        <!--登录end-->
    </div>

    <!--注册-->
    <c:choose>
        <c:when test="${requestScope.act eq 'regist'}">
            <div class="qlogin" id="qlogin" style="display: block; ">
        </c:when>
        <c:otherwise>
            <div class="qlogin" id="qlogin" style="display: none; ">
        </c:otherwise>
    </c:choose>
        <div class="web_login"><form name="regForm" id="regUser" accept-charset="utf-8"  action="<%=SystemConst.BASE_PATH%>login/registerUser" method="post">
            <input type="hidden" name="to" value="reg"/>
            <input type="hidden" name="did" value="0"/>
            <ul class="reg_form" id="reg-ul">
                <div id="userCue" class="cue">快速注册请注意格式</div>
                <li>

                    <label for="user"  class="input-tips2">用户名：</label>
                    <div class="inputOuter2">
                        <input type="text" id="user" name="userName" maxlength="16" class="inputstyle2"/>
                    </div>

                </li>

                <li>
                    <label for="passwd" class="input-tips2">密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="passwd"  name="pwd" maxlength="16" class="inputstyle2"/>
                    </div>

                </li>
                <li>
                    <label for="passwd2" class="input-tips2">确认密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="passwd2" name="" maxlength="16" class="inputstyle2" />
                    </div>

                </li>

                <li>
                    <label for="trueName" class="input-tips2">真实姓名：</label>
                    <div class="inputOuter2">

                        <input type="text" id="trueName" name="trueName" maxlength="16" class="inputstyle2"/>
                    </div>

                </li>

                <li>
                    <label for="nickName" class="input-tips2">昵称：</label>
                    <div class="inputOuter2">

                        <input type="text" id="nickName" name="nickName" maxlength="10" class="inputstyle2"/>
                    </div>

                </li>

                <li>
                    <div style="padding-left:80px;margin-top:20px;"><input type="submit" id="reg" value="完成注册" style="width:150px;" class="button_blue" /></div>

                </li><div class="cl"></div>
            </ul></form>


        </div>


    </div>
    <!--注册end-->
</div>

</body></html>
