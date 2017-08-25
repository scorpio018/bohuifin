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
                                    <h3 class="header smaller lighter blue">增加产品</h3>
                                </c:if>
                                <c:if test="${!requestScope.act eq 'edit'}">
                                    <h3 class="header smaller lighter blue">修改产品</h3>
                                </c:if>
                            </h3>
                            <form action="<%=SystemConst.BASE_PATH%>admin/products/saveProduct"
                                  method="post" class="form-horizontal" id="productForm">
                                <div class="table-responsive" id="responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <tr>
                                            <td style="width:10%;">产品名称</td>
                                            <td><input type="text" class="col-xs-10 col-sm-5"
                                                       name="productName" id="productName"
                                                       value="${requestScope.product.productName }"
                                                       style="display: inline;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">产品介绍</td>
                                            <td>
                                                <textarea class="autosize-transition form-control" name="introduce" id="introduce">${requestScope.product.introduce }</textarea>
                                            </td>
                                        </tr>
                                        <c:if test="${sessionScope.managerLogin ne null}">
                                            <tr>
                                                <td style="width:10%;">交易员</td>
                                                <td>
                                                    <select class="chosen-select input-medium" name="dealerId" id="dealerId">
                                                        <c:forEach items="${requestScope.dealers}" var="dealer">
                                                            <c:choose>
                                                                <c:when test="${requestScope.product.dealerId eq dealer.dealerId}">
                                                                    <option value="${dealer.dealerId}" selected>${dealer.trueName}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${dealer.dealerId}">${dealer.trueName}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td style="width:10%;">产品类型</td>
                                            <td>
                                                <select class="form-control input-medium" name="productTypeId" id="productTypeId">
                                                    <c:forEach items="${requestScope.productTypes}" var="productType">
                                                        <c:choose>
                                                            <c:when test="${requestScope.product.productTypeId eq productType.productTypeId}">
                                                                <option value="${productType.productTypeId}" selected>${productType.productTypeName}</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${productType.productTypeId}">${productType.productTypeName}</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">产品金额</td>
                                            <td>
                                                <input type="text" class="col-xs-1" name="projectAmount" id="projectAmount" value="${requestScope.product.projectAmount}"
                                                        style="display: inline;"/>
                                                <span class="lbl">
                                                    <span class="middle">元</span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">管理费</td>
                                            <td>
                                                <input type="text" class="col-xs-1" name="managementCost" id="managementCost" value="${requestScope.product.managementCost}"
                                                       style="display: inline;">
                                                <span class="lbl">
                                                    <span class="middle">%</span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">止损值</td>
                                            <td>
                                                <input type="text" class="col-xs-1" name="stopLossValue" id="stopLossValue" value="${requestScope.product.stopLossValue}"
                                                       style="display: inline;">
                                                <span class="lbl">
                                                    <span class="middle">%</span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">预期收益率（保底收益）</td>
                                            <td>
                                                <input type="text" class="col-xs-1" name="expectedYield" id="expectedYield" value="${requestScope.product.expectedYield}"
                                                       style="display: inline;">
                                                <span class="lbl">
                                                    <span class="middle">% (年化)</span>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:10%;">交易周期</td>
                                            <td>
                                                <input type="text" class="col-xs-1" name="tradingCycle" id="tradingCycle" value="${requestScope.product.tradingCycle}"
                                                       style="display: inline;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 10%;">标签</td>
                                            <td>
                                                <input type="text" name="tagNames" id="productTags" value="${requestScope.tagNames}" placeholder="请输入产品标签" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 10%;">星级</td>
                                            <td>
                                                <input type="text" name="starLevel" value="${requestScope.product.starLevel}" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>排序</td>
                                            <td><c:choose>
                                                <c:when test="${requestScope.product.listOrder eq 0 }">
                                                    <input type="text" class="col-xs-1" name="listOrder" value="${requestScope.product.listOrder}"
                                                           style="display: inline;">
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="col-xs-1" name="listOrder"
                                                           value="${requestScope.product.listOrder }"
                                                           style="display: inline;">
                                                </c:otherwise>
                                            </c:choose></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="center">
                                                <c:if test="${sessionScope.dealerLogin ne null}">
                                                    <input type="hidden" name="dealerId" value="${sessionScope.dealerLogin.dealerId}"/>
                                                </c:if>
                                                <input type="hidden" name="productId" value="${requestScope.product.productId}"/>
                                                <input type="hidden" name="operStateId" value="${requestScope.firstOperStateBean.operStateId}"/>
                                                <input type="hidden" name="pageNo" value="${requestScope.page.pageNo }"/>
                                                <input type="hidden" name="pageSize"
                                                       value="${requestScope.page.pageSize }">
                                                <input type="hidden" name="act" value="${requestScope.act}"/>
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
        $('#productForm').validate({
            errorElement: 'label',
            errorClass: 'help-block',
            rules: {
                productName: {
                    required: true,
                    minlength: 1,
                    maxlength: 100
                },
                introduce: {
                    required: true,
                    minlength: 1
                },
                starLevel: {
                    required: true,
                    maxlength: 2,
                    minlength: 1
                },
                listOrder: {
                    required: true,
                    maxlength: 5,
                    minlength: 1
                }
            },
            messages: {
                productName: {
                    required: "产品名不能为空",
                    maxlength: "产品名不得超过100个字"
                },
                introduce: {
                    required: "真实姓名不能为空"
                },
                starLevel: {
                    required: "星级不能为空"
                },
                listOrder: {
                    required: "排序不能为空"
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

        $( "#input-size-slider" ).css('width','200px').slider({
            value:1,
            range: "min",
            min: 1,
            max: 8,
            step: 1,
            slide: function( event, ui ) {
                var sizing = ['', 'input-sm', 'input-lg', 'input-mini', 'input-small', 'input-medium', 'input-large', 'input-xlarge', 'input-xxlarge'];
                var val = parseInt(ui.value);
                $('#form-field-4').attr('class', sizing[val]).val('.'+sizing[val]);
            }
        });

        $('#spinner3').ace_spinner({value:1,min:1,max:10,step:1, on_sides: true, icon_up:'icon-plus smaller-75', icon_down:'icon-minus smaller-75', btn_up_class:'btn-success' , btn_down_class:'btn-danger'});
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

