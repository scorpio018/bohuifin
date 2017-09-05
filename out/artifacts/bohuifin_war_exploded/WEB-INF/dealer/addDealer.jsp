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
    <%@include file="/common/common-extra.jsp"%>
    <script src="<%=SystemConst.BASE_PATH%>js/common/ace-extra.js"/>
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
                                    <h3 class="header smaller lighter blue">增加操作员</h3>
                                </c:if>
                                <c:if test="${!requestScope.act eq 'edit'}">
                                    <h3 class="header smaller lighter blue">修改操作员</h3>
                                </c:if>
                            </h3>
                            <form action="<%=SystemConst.BASE_PATH%>admin/dealers/saveDealer"
                                  method="post" class="form-horizontal" id="dealerForm" enctype="multipart/form-data">
                                <div class="table-responsive" id="responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <tr>
                                            <td style="width:10%;">操作员名称</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="dealerName" id="dealerName"
                                                       value="${requestScope.dealer.dealerName }"
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
                                                       value="${requestScope.dealer.trueName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">昵称</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="nickName" id="nickName"
                                                       value="${requestScope.dealer.nickName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">头像</td>
                                            <td>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <%-- id="input-file-img"--%>
                                                        <input type="file" name="headImgFile" value="${requestScope.dealer.headImg}" />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">个人简介</td>
                                            <td>
                                                <textarea class="autosize-transition form-control" name="introduce" id="introduce">${requestScope.dealer.introduce }</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">投资理念</td>
                                            <td>
                                                <textarea class="autosize-transition form-control" name="investmentPhilosophy" id="investmentPhilosophy">${requestScope.dealer.investmentPhilosophy }</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">投资策略</td>
                                            <td>
                                                <textarea class="autosize-transition form-control" name="investmentStrategy" id="investmentStrategy">${requestScope.dealer.investmentStrategy }</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="center">
                                                <input type="hidden" name="deptId" value="0"/>
                                                <input type="hidden" name="dealerId" value="${requestScope.dealer.dealerId}"/>
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
        $('#dealerForm').validate({
            errorElement: 'label',
            errorClass: 'help-block',
            rules: {
                dealerName: {
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
                },
                introduce: {
                    required: true
                },
                investmentPhilosophy: {
                    required: true
                },
                investmentStrategy: {
                    required: true
                }
            },
            messages: {
                dealerName: {
                    required: "操作员名不能为空",
                    maxlength: "操作员名不得超过16个字"
                },
                trueName: {
                    required: "真实姓名不能为空",
                    maxlength: "真实姓名的不得超过16个字"
                },
                nickName: {
                    required: "昵称不能为空",
                    maxlength: "昵称不得超过16个字"
                },
                introduce: {
                    required: "个人简介不能为空"
                },
                investmentPhilosophy: {
                    required: "投资理念不能为空"
                },
                investmentStrategy: {
                    required: "投资策略不能为空"
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

