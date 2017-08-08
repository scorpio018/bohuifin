<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                var operStateStartTimes = new Array();
                operStateStartTimes.push($("#operStateStartTime1").val());
                operStateStartTimes.push($("#operStateStartTime2").val());
                operStateStartTimes.push($("#operStateStartTime3").val());
                operStateStartTimes.push($("#operStateStartTime4").val());
                $("#operStateStartTime").val(operStateStartTimes);
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
                                <h3 class="header smaller lighter blue">设置产品投资状态对应时间段</h3>
                            </h3>
                            <form action="<%=SystemConst.BASE_PATH%>admin/product_oper_state/saveOperState"
                                  method="post" class="form-horizontal" id="productOperStateForm">
                                <div class="table-responsive" id="responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>投资状态</th>
                                                <th>投资状态对应时间段</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>等待开始</td>
                                                <td>
                                                    <input class="form-control date-picker" type="text"
                                                           name="operStateStartTime1" id="operStateStartTime1" value="<fmt:formatDate value="${requestScope.WAITING_FOR_START }" pattern="yyyy-MM-dd"/>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>募集中</td>
                                                <td>
                                                    <input class="form-control date-picker" type="text"
                                                           name="operStateStartTime2" id="operStateStartTime2" value="<fmt:formatDate value="${requestScope.TO_RAISE }" pattern="yyyy-MM-dd"/>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>正在投资</td>
                                                <td>
                                                    <input class="form-control date-picker" type="text"
                                                           name="operStateStartTime3" id="operStateStartTime3" value="<fmt:formatDate value="${requestScope.IS_INVESTING }" pattern="yyyy-MM-dd"/>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>投资结束</td>
                                                <td>
                                                    <input class="form-control date-picker" type="text"
                                                           name="operStateStartTime4" id="operStateStartTime4" value="<fmt:formatDate value="${requestScope.INVESTMENT_OVER }" pattern="yyyy-MM-dd"/>"/>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <tr>
                                            <td colspan="2" class="center">
                                                <input type="hidden" name="productId" value="${requestScope.productId}"/>
                                                <input type="hidden" name="operStateStartTime" id="operStateStartTime"/>
                                                <input type="submit"
                                                       value="确定" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="button" value="取消" class="btn btn-primary" onclick="back();">
                                            </td>
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
        $(".chosen-select").chosen();
        $('#productOperStateForm').validate({
            errorElement: 'label',
            errorClass: 'help-block',
            rules: {
                operStateStartTime1: {
                    required: true,
                    minlength: 1,
                    maxlength: 100
                },
                operStateStartTime2: {
                    required: true,
                    minlength: 1,
                    maxlength: 100
                },
                operStateStartTime3: {
                    required: true,
                    minlength: 1,
                    maxlength: 100
                },
                operStateStartTime4: {
                    required: true,
                    minlength: 1,
                    maxlength: 100
                }
            },
            messages: {
                operStateStartTime1: {
                    required: "请选择产品“等待开始”状态的开始时间"
                },
                operStateStartTime2: {
                    required: "请选择产品“募集中”状态的开始时间"
                },
                operStateStartTime3: {
                    required: "请选择产品“正在投资”状态的开始时间"
                },
                operStateStartTime4: {
                    required: "请选择产品“投资结束”状态的开始时间"
                },

            },
            errorPlacement: function (error, element) {
                $(element).closest("td").append(error);
// 					if ($(element).next("#msg").length>0) {
// 						error.appendTo($(element).next("#msg"));
// 					} else {

// 					}
            }
        });

        $('.date-picker').datepicker({autoclose: true, language: 'en'}).next().on(ace.click_event, function () {
            $(this).prev().focus();
        });

        //we could just set the data-provide="tag" of the element inside HTML, but IE8 fails!
        var tag_input = $('#productTags');
        if(! ( /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase())) )
        {
            tag_input.tag(
                {
                    placeholder:tag_input.attr('placeholder'),
                    //enable typeahead by specifying the source array
                    source: ace.variable_US_STATES,//defined in ace.js >> ace.enable_search_ahead
                }
            );
        }
        else {
            //display a textarea for old IE, because it doesn't support this plugin or another one I tried!
            tag_input.after('<textarea id="'+tag_input.attr('id')+'" name="'+tag_input.attr('name')+'" rows="3">'+tag_input.val()+'</textarea>').remove();
            //$('#productTags').autosize({append: "\n"});
        }
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

