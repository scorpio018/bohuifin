<%@page import="cn.com.bohui.bohuifin.common.*" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <!-- basic styles -->

    <link href="<%=SystemConst.BASE_PATH%>js/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/font-awesome.min.css"/>

    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/jquery-ui-1.10.3.full.min.css"/>

    <!--[if IE 7]>
    <link rel="stylesheet" href="js/assets/css/font-awesome-ie7.min.css"/>
    <![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->
    <!-- ace styles -->

    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/blink.css"/>
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="js/assets/css/ace-ie.min.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->

    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace-extra.min.js"></script>
    <link href="js/bootstrap3-dialog/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="js/sweetAlert/sweet-alert.css"/>
    <script src="js/sweetAlert/sweet-alert.min.js"></script>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 10]>
    <script src="js/assets/js/html5shiv.js"></script>
    <script src="js/assets/js/respond.min.js"></script>
    <![endif]-->
    <!--[if lt IE 9]>
    <style type="text/css">
        .browser-happy {
            position: absolute;
            left: 0px;
            right: 0px;
            top: 0px;
            bottom: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            background-color: #24a6fa;
        }

        .content {
            text-align: center;
            color: #fff;
            z-index: 9999;
            font-size: 24px;
        }
    </style>
    <![endif]-->
</head>

<body>
<div class="navbar navbar-default" id="navbar">
    <script type="text/javascript">
        try {
            ace.settings.check('navbar', 'fixed')
        } catch (e) {
        }
    </script>
    <!--[if lt IE 9]>
    <div class="browser-happy">
        <div class="content">
            <p><%=SystemConst.SYSTEM_NAME %>不支持IE9及以下浏览器访问！</p>
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
    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left">
					<span class="navbar-brand">
						<small>
							<%=SystemConst.SYSTEM_NAME%>
						</small>
					</span><!-- /.brand -->
        </div><!-- /.navbar-header -->

        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">

                <li class="purple">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon-bell-alt icon-animated-bell"></i>
                        <span class="badge badge-important">${fn:length(waitReplyTask)}</span>
                    </a>

                    <ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
                        <li class="dropdown-header">
                            <i class="icon-warning-sign"></i>
                            ${fn:length(waitReplyTask)}个待答复任务
                        </li>
                        <c:if test="${fn:length(waitReplyTask)>0}">
                            <c:forEach items="${waitReplyTask}" var="task" end="3">
                                <li>
                                    <a href="">
                                        <div class="clearfix">
													<span class="pull-left">
														<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
														${task.title}
													</span>
                                            <span class="pull-right badge badge-info"> <fmt:formatDate
                                                    value="${task.delegateDate}" type="both"
                                                    pattern="yyyy.MM.dd"/></span>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>

                            <li>
                                <a href="">
                                    查看全部待答复任务
                                    <i class="icon-arrow-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>

                <li class="light-blue">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <i class="icon-user"></i> ${sessionScope.managerLogin.trueName}${sessionScope.dealerLogin.trueName}
                        <span class="user-info">
									<small>&nbsp;</small>
									<span></span>
								</span>
                        <i class="icon-caret-down"></i>
                    </a>

                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="javascript:void(0);" onclick="changeWord();">
                                <i class="icon-cog"></i>
                                修改登录密码
                            </a>
                        </li>
                        <!--
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-user"></i>
                                                                Profile
                                                            </a>
                                                        </li>
                         -->
                        <li class="divider"></li>

                        <li>
                            <a href="<%=SystemConst.BASE_PATH%>login/logout">
                                <i class="icon-off"></i>
                                登出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul><!-- /.ace-nav -->
        </div><!-- /.navbar-header -->
    </div><!-- /.container -->
</div>

<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>
        <div class="sidebar" id="sidebar">
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'fixed')
                } catch (e) {
                }
            </script>
            <ul class="nav nav-list">
                <c:forEach items="${sessionScope.menuBeans}" var="bean">
                    <c:choose>
                        <c:when test="${fn:length(bean.authorityMenuVoList) ne 0}">
                            <li>
                                <a href="#" class="dropdown-toggle">
                                    <i class="${bean.authorityBean.authorityCode}"></i>
                                    <span class="menu-text">${bean.authorityBean.authorityName}</span>

                                    <b class="arrow icon-angle-down"></b>
                                </a>
                                <ul class="submenu">
                                    <c:forEach items="${bean.authorityMenuVoList}" var="subBean">
                                        <li id="${subBean.authorityBean.authorityCode}">
                                            <a href="${subBean.authorityBean.authorityUrl}">
                                                <i class="${subBean.authorityBean.authorityCode}"></i>
                                                ${subBean.authorityBean.authorityName}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li id="${bean.authorityBean.authorityCode}">
                                <a href="${bean.authorityBean.authorityUrl}">
                                    <i class="${bean.authorityBean.authorityCode}"></i>
                                    <span class="menu-text">${bean.authorityBean.authorityName}</span>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>

            </ul><!-- /.nav-list -->

            <div class="sidebar-collapse" id="sidebar-collapse">
                <i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
                   data-icon2="icon-double-angle-right"></i>
            </div>
        </div>
    </div><!-- /.main-content -->
</div><!-- /.main-container -->
<!-- basic scripts -->
<!--[if !IE]> -->


<!-- <![endif]-->

<!--[if !IE]> -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery-1.10.2.min.js'>" + "<" + "/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='<%=SystemConst.BASE_PATH%>js/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/bootstrap.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/typeahead-bs2.min.js"></script>

<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery-ui-1.10.3.full.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.ui.touch-punch.min.js"></script>

<!-- page specific plugin scripts -->

<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.dataTables.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.dataTables.bootstrap.js"></script>

<!-- ace scripts -->
<script src="<%=SystemConst.BASE_PATH%>js/bootstrap3-dialog/js/bootstrap-dialog.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace-elements.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/assets/js/jquery.slimscroll.min.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/common/hints.js"></script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
    $().ready(function () {
        ace.settings.sidebar_collapsed(${sessionScope.collapsed});
        if ($("#${sessionScope.menuName}").parent().attr("class") == "submenu") {
            $("#${sessionScope.menuName}").parent().parent().addClass("open");
            $("#${sessionScope.menuName}").parent().parent().addClass("active");
            $("#${sessionScope.menuName}").parent().css("display", "block");
        }
        if ($("#${sessionScope.menuName}").parent().parent().hasClass("open")) {
            $("#${sessionScope.menuName}").parent().closest("li").find("a:first").find("b").removeClass("arrow icon-angle-down").addClass("arrow icon-angle-up");
        } else {
            $("#${sessionScope.menuName}").parent().closest("li").find("a:first").find("b").removeClass("arrow icon-angle-up").addClass("arrow icon-angle-down");
        }
        $("#${sessionScope.menuName}").addClass("active");

        /* $('.slim-scroll').each(function () {
         var $this = $(this);
         $this.slimScroll({
         height: $this.data('height') || 100,
         railVisible:true
         });
         }); */
    })

    setInterval("aad()", 10);

    function aad() {
        var sidebar = $("#sidebar").width();
        $(".main-content").css("margin-left", sidebar + 1);
    }

    function changeWord() {
        BootstrapDialog.show({
            title: '修改密码',
            <c:choose>
            <c:when test="${sessionScope.managerLogin ne null}">message: $('<div></div>').load('admin/managers/changePwd'),</c:when>
            <c:otherwise>message: $('<div></div>').load('admin/dealers/changePwd'),</c:otherwise>
            </c:choose>

            buttons: [{
                label: '确定',
                cssClass: 'btn-primary',
                hotkey: 13, // Enter.
                action: function (dialogItself) {
                    var swalType = "success";
                    var swalTitle = "您的密码修改成功，请牢记密码。";
                    var closeDiag = true;
                    if ($("#form-field-1").val() == '' || $("#form-field-1").val() == null) {
                        swalType = "error";
                        swalTitle = "请输入当前密码。";
                        closeDiag = false;
                    } else if ($("#form-field-2").val() == '' || $("#form-field-2").val() == null) {
                        swalType = "error";
                        swalTitle = "请输入新密码。";
                        closeDiag = false;
                    } else if ($("#form-field-2").val().length < 6) {
                        swalType = "error";
                        swalTitle = "新密码长度过低（6位以上）";
                        closeDiag = false;
                    } else if ($("#form-field-3").val() == '' || $("#form-field-3").val() == null) {
                        swalType = "error";
                        swalTitle = "请输入确认新密码。";
                        closeDiag = false;
                    } else if ($("#form-field-2").val() != $("#form-field-3").val()) {
                        swalType = "error";
                        swalTitle = "两次输入的密码不一致，请重新输入。";
                        closeDiag = false;
                    }
                    if (!closeDiag) {
                        swal({
                            title: "<strong><h3>" + swalTitle + "</strong></h3>",
                            type: swalType,
                            confirmButtonColor: "#428bca",
                            confirmButtonText: "确定",
                            html: true
                        });
                    } else {
                        $.ajax({
                            <c:choose>
                            <c:when test="${sessionScope.managerLogin ne null}">
                            url : "admin/managers/newPassword",
                            </c:when>
                            <c:otherwise>
                            url : "admin/dealers/newPassword",
                            </c:otherwise>
                            </c:choose>
                            type : "POST",
                            data : {
                                "oldPwd" : $("#form-field-1").val(),
                                "newPwd": $("#form-field-2").val()
                            },
                            dataType : "json",
                            success : function(data) {
                                if (!data) {
                                    errorAlert("修改密码失败，请确认密码是否输入正确。");
                                } else {
                                    successAlert("修改成功", "请牢记您的密码", false);
                                    dialogItself.close();
                                }
                            }
                        })
                    }
                }
            }, {
                label: '关闭',
                action: function (dialogItself) {
                    dialogItself.close();
                }
            }]
        });
    }

</script>
</body>
</html>

