<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>

<html>
<head>
    <base href="<%=SystemConst.BASE_PATH%>">
    <title><%=SystemConst.SYSTEM_NAME%>
    </title>
    <%@include file="/common/common.jsp" %>
    <%@include file="/common/showTablePage.jsp" %>
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="js/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="js/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="js/assets/css/chosen.css"/>
    <link rel="stylesheet" href="js/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="js/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="js/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/style.css"/>
    <script src="js/assets/js/jquery.validate.min.js"></script>
    <script src="js/assets/js/chosen.jquery.min.js"></script>
    <script src="js/assets/js/date-time/bootstrap-datepicker.zh-CN.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            var error = "${requestScope.error}";
            if (error != "") {
                swal({
                    title : error,
                    type : "warning",
                    confirmButtonColor : "#428bca",
                    confirmButtonText : "确定"
                })
            }
            var before_change;
            var btn_choose;
            var no_icon;
            before_change = function (files, dropped) {
                var allowed_files = [];
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    if (typeof file === "string") {
                        //IE8 and browsers that don't support File Object
                        if (!(/\.(jpe?g|png|gif|bmp)$/i).test(file)) return false;
                    }
                    else {
                        var type = $.trim(file.type);
                        if (( type.length > 0 && !(/^image\/(jpe?g|png|gif|bmp)$/i).test(type) )
                            || ( type.length == 0 && !(/\.(jpe?g|png|gif|bmp)$/i).test(file.name) )//for android's default browser which gives an empty string for file.type
                        ) continue;//not an image so don't keep this file
                    }

                    allowed_files.push(file);
                }
                if (allowed_files.length == 0) return false;

                return allowed_files;
            }
            var file_input = $('#id-input-file-3');
            file_input.ace_file_input('update_settings', {
                'before_change': before_change,
                'btn_choose': btn_choose,
                'no_icon': no_icon
            })
            file_input.ace_file_input('reset_input');

            $("form").submit(function () {

                return true;
            })
        })
    </script>
</head>

<body>

<div class="main-container-inner">
    <div class="main-content">
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12">
                            <h3 class="header smaller lighter blue">
                                <c:if test="${!requestScope.act eq 'add'}">
                                    <h3 class="header smaller lighter blue">增加用户</h3>
                                </c:if>
                                <c:if test="${!requestScope.act eq 'edit'}">
                                    <h3 class="header smaller lighter blue">修改用户</h3>
                                </c:if>
                            </h3>
                            <form action="<%=SystemConst.BASE_PATH%>admin/users/saveUser"
                                  method="post" class="form-horizontal" id="userForm">
                                <div class="table-responsive" id="responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <tr>
                                            <td style="width:10%;">用户名称</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="userName" id="userName"
                                                       value="${requestScope.user.userName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <c:if test="${requestScope.act eq 'add'}">
                                            <tr>
                                                <td style="width:10%;">密码</td>
                                                <td><input type="password" class="col-xs-10 col-sm-5"
                                                           name="pwd" id="pwd"
                                                           style="display: inline;"></td>
                                            </tr>
                                        </c:if>

                                        <tr>
                                            <td style="width:10%;">真实姓名</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="trueName" id="trueName"
                                                       value="${requestScope.user.trueName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">昵称</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="nickName" id="nickName"
                                                       value="${requestScope.user.nickName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <%--<tr>
                                            <td>排序</td>
                                            <td><c:choose>
                                                <c:when test="${requestScope.user.listOrder eq 0 }">
                                                    <input type="text" class="col-xs-1" name="listOrder"
                                                           style="display: inline;">
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="col-xs-1" name="listOrder"
                                                           value="${requestScope.user.listOrder }"
                                                           style="display: inline;">
                                                </c:otherwise>
                                            </c:choose></td>
                                        </tr>--%>
                                        <tr>
                                            <td colspan="2" class="center">
                                                <input type="hidden" name="deptId" value="0"/>
                                                <input type="hidden" name="userId" value="${requestScope.user.userId}"/>
                                                <input type="hidden" name="pageNo" value="${requestScope.page.pageNo }"/>
                                                <input type="hidden" name="pageSize"
                                                       value="${requestScope.page.pageSize }">
                                                <input type="hidden" name="keyword" value="${requestScope.keyword}"/>
                                                <input type="hidden" name="act" value="${requestScope.act}"/>
                                                <input type="submit"
                                                       value="确定" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;<input
                                                    type="button" value="取消" class="btn btn-primary"
                                                    onclick="back();"></td>
                                        </tr>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="show" style="display: none;">
    <div id="hint" class="alert alert-success alert-dismissible" role="alert"
         style="float: left; height: 35px; padding-top: 5px; margin-left: 5px;">
        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true"
                                                                       style="color: red;">&times;</span><span
                class="sr-only">Close</span></button>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#userForm').validate({
            errorElement: 'label',
            errorClass: 'help-block',
            rules: {
                userName: {
                    required: true,
                    minlength: 1,
                    maxlength: 16
                },
                trueName: {
                    required: true,
                    minlength: 1,
                    maxlength: 16
                },
                nickName: {
                    required: true,
                    minlength: 1,
                    maxlength: 16
                }
            },
            messages: {
                userName: {
                    required: "用户名不能为空",
                    maxlength: "用户名不得超过16个字"
                },
                trueName: {
                    required: "真实姓名不能为空",
                    maxlength: "真实姓名的不得超过16个字"
                },
                nickName: {
                    required: "昵称不能为空",
                    maxlength: "昵称不得超过16个字"
                }
            },
            errorPlacement: function (error, element) {
                $(element).closest("td").append(error);
// 					if ($(element).next("#msg").length>0) {
// 						error.appendTo($(element).next("#msg"));
// 					} else {

// 					}
            }
        });

        $('.date-picker').datepicker({autoclose: true, language: 'zh-CN'}).next().on(ace.click_event, function () {
            $(this).prev().focus();
        });
    });
    function back() {
        window.history.go(-1);
        <%-- if ("${requestScope.parentVo}" != "") {
            window.location.href="<%=SystemConst.BASE_PATH%>dept/showDept?parentId=${requestScope.parentVo.deptId}";
        } else {
            window.location.href="<%=SystemConst.BASE_PATH%>dept/showDept?parentId=-1";
        } --%>
    }
</script>
</body>
</html>

