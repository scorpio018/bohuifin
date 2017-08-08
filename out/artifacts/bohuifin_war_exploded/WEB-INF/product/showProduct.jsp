<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=SystemConst.BASE_PATH%>">
    <%@include file="/common/common.jsp"%>
    <%@include file="/common/showTablePage.jsp"%>
    <title><%=SystemConst.SYSTEM_NAME%></title>
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="js/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="js/assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="js/assets/css/ace.min.css" />
    <link rel="stylesheet" href="js/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="js/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="js/sweetAlert/sweet-alert.css" />
    <link rel="stylesheet" href="css/style.css" />
    <script src="js/assets/js/chosen.jquery.min.js"></script>
    <script src="js/sweetAlert/sweet-alert.min.js"></script>
</head>

<body>
<div class="main-container-inner">
    <div class="main-content">
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12">
                            <br>
                            <div>
                                <form class="form-inline" id="productForm">
                                    <span class="ziti">产品名：</span>
                                    <input type="text" id="productName" name="productName" value="${requestScope.page.vo.productName}"
                                           placeholder="按产品名查询" style="width:200px;" class="ziti">
                                    &nbsp;&nbsp;<span class="ziti">产品种类：</span>
                                    <select id="productTypeId" class="form-control ziti" name="productTypeId" style="max-width: 200px;">
                                        <option value="0">请选择</option>
                                        <c:forEach items="${requestScope.productTypes}" var="productType">
                                            <c:choose>
                                                <c:when test="${productType.productTypeId eq requestScope.page.vo.productTypeId}">
                                                    <option value="${productType.productTypeId}" selected>${productType.productTypeName}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${productType.productTypeId}">${productType.productTypeName}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    <c:if test="${sessionScope.managerLogin != null}">
                                        &nbsp;&nbsp;<span class="ziti">交易员：</span>
                                        <select id="dealerId" name="dealerId" class="form-control ziti" style="max-width:200px;">
                                            <option value="0">请选择</option>
                                            <c:forEach items="${requestScope.dealers}" var="dealer">
                                                <c:choose>
                                                    <c:when test="${dealer.dealerId eq requestScope.page.vo.dealerId}">
                                                        <option value="${dealer.dealerId}" selected>${dealer.dealerName}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${dealer.dealerId}">${dealer.dealerName}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </c:if>
                                    &nbsp;&nbsp;<span class="ziti">投资状态：</span>
                                    <select id="operStateId" name="operStateId" class="form-control ziti" style="max-width:200px;">
                                        <option value="0">请选择</option>
                                        <c:forEach items="${requestScope.operStates}" var="operState">
                                            <c:choose>
                                                <c:when test="${operState.operStateId eq requestScope.page.vo.operStateId}">
                                                    <option value="${operState.operStateId}" selected>${operState.operStateName}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${operState.operStateId}">${operState.operStateName}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="button" class="btn btn-sm btn-primary"
                                            style="height:28px;" onclick="search();">
                                        <p class="ziti" style="margin-top:-3px;">查询</p>
                                    </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="javascript:void(0)" class="btn btn-sm btn-primary" style="height:28px;" onclick="add();">
                                        <p class="ziti" style="margin-top:-3px;">新建产品</p>
                                    </a>&nbsp;&nbsp;
                                    <a href="javascript:void(0);" class="btn btn-sm btn-primary" style="height:28px;" onclick="batchDel();">
                                        <p class="ziti" style="margin-top:-3px;">批量删除</p>
                                    </a>
                                </form>

                            </div>
                            <br>
                            <div class="row">
                                <div class="col-xs-12">
                                    <!-- PAGE CONTENT BEGINS -->
                                    <div class="table-responsive" id="responsive">
                                        <table id="grid-table"></table>
                                        <div id="grid-pager"></div>
                                    </div>
                                    <!-- PAGE CONTENT ENDS -->
                                </div>
                                <!-- /.col -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /.row -->
<script type="text/javascript">
    $(function() {
        <c:if test="${requestScope.error ne null}">
        swal({
            title : "${requestScope.error}",
            type : "warning",
            confirmButtonColor : "#428bca",
            confirmButtonText : "确定"
        })
        </c:if>
        initAjax();
        init();
    });

    function initAjax() {
        jQuery(grid_selector).jqGrid({
            url : "admin/products/productData",
            contentType : 'application/json',
            datatype : "json",
            postData : $("#productForm").serialize(),
            jsonReader : {
                total : "totalPage",
                root : "results",
                records : "totalRecord"
            },
            prmNames : {
                rows : "pageSize",
                page : "pageNo"
            },
            height : "auto",
            viewrecords : true,
            rowNum : '${page.pageSize}',
            rowList : [ 5, 10, 15,20, 30 ],
            pager : pager_selector,
            page:'${page.pageNo}',
            altRows : false,
            emptyrecords : "无可用数据",
            //toppager: true,
            loadComplete : function() {
                $("#grid-table").closest("div.ui-jqgrid-view").find(".ui-jqgrid-sortable").css("text-align", "center");
                var table = this;
                setTimeout(function() {
                    styleCheckbox(table);
                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            },
            autowidth : true,
            colNames : ['产品编号','产品名','交易员', '产品类型', '投资状态', '审核状态', '管理费', '止损值', '预期收益率', '排序', '操作'],
            colModel : [
                {name:'productId',index:'p.product_id', width:40,key:true,align:'center'},
                {name:'productName',index:'p.product_name', width:40,align:'center'},
                {name:'dealerBean.trueName',index:'d.true_name', width:45,align:'center'},
                {name:'productTypeBean.productTypeName',index:'pt.product_type_name', width:45,align:'center'},
                {name:'operStateBean.operStateName',index:'os.oper_state_name', width:45,align:'center'},
                {name:'state',index:'p.state', width:45,align:'center',
                    formatter : function (cellvalue, options, rowObject) {
                        if (cellvalue == 1) {
                            return "未审核";
                        } else if (cellvalue == 2000) {
                            return "审核通过";
                        } else if (cellvalue == -2000) {
                            return "审核拒绝";
                        }
                    }
                },
                {name:'managementCost',index:'p.management_cost', width:45,align:'center'},
                {name:'stopLossValue',index:'p.stop_loss_value', width:45,align:'center'},
                {name:'expectedYield',index:'p.expected_yield', width:45,align:'center'},
                {name:'listOrder',index:'p.list_order', width:20,align:'center'},
                {name:'productId',index:'product_id', width:240, fixed:true,resize:false,title:false,sortable:false,
                    formatter : function(cellvalue, options, rowObject) {
                        var tmp="<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>";
                        <c:if test="${sessionScope.managerLogin != null}">
                        if (rowObject.state == 2000) {
                            tmp += "<a href='<%=SystemConst.BASE_PATH%>admin/products/changeProductState?productId=" + cellvalue + "&state=-2000' title='审核拒绝' >审核拒绝</a> ";
                        } else {
                            tmp += "<a href='<%=SystemConst.BASE_PATH%>admin/products/changeProductState?productId=" + cellvalue + "&state=2000' title='审核通过' >审核通过</a> ";
                        }
                        </c:if>
                        <c:if test="${sessionScope.dealerLogin != null}">
                        if (rowObject.state != 2000) {
                            tmp += "<a href='<%=SystemConst.BASE_PATH%>admin/product_oper_state/showAddOperState?productId=" + cellvalue + "' title='设置投资状态时间' >设置投资状态时间</a> ";
                        } else {
                            if (!rowObject.hasCurDayIncome) {
                                tmp += "<a href='<%=SystemConst.BASE_PATH%>admin/productIncomeRecord/addIncomeBegin?productId=" + cellvalue + "' title='设置产品收益' >设置产品收益</a> ";
                            }
                        }
                        </c:if>
                        tmp += "<a href='javascript:void(0);' onclick='edit("+cellvalue+")' title='编辑' >编辑</a> ";
                        tmp += "<a href='javascript:void(0);' onclick='del(\""+cellvalue+"\", \"" + rowObject.productName + "\");' title='删除' >删除</a>";
                        return tmp+"</div>";
                    }
                }
            ],
            multiselect: true,
            multiboxonly: true,
            caption : "产品列表",
            autowidth : true,

        });
    }

    setInterval("resizeaa()",10);

    function edit(productId) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        window.location.href="<%=SystemConst.BASE_PATH%>admin/products/showAddProduct?productId=" + productId + "&pageNo="+pageNo+"&pageSize="+pageSize + "&act=edit&" + $("#productForm").serialize();
    }

    function resizeaa() {
        $(grid_selector).jqGrid('setGridWidth', $("#responsive").width());
    }

    function search() {
        $(grid_selector).setGridParam({
            page:1,
            postData : $("#productForm").serialize()
        }).trigger("reloadGrid");
    }

    function add() {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        window.location.href = "<%=SystemConst.BASE_PATH%>admin/products/showAddProduct?pageNo="+pageNo+"&pageSize="+pageSize + "&act=add&" + $("#productForm").serialize();
    }

    function del(productId, delProductName) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        swal({
            title : "确认删除【" + delProductName + "】?",
            type : "warning",
            showCancelButton : true,
            cancelButtonText : "取消",
            confirmButtonColor : "#428bca",
            confirmButtonText : "确定",
            closeOnConfirm : false
        },function(){
            $.ajax({
                url : "admin/products/beforeDel",
                type : "POST",
                data : {
                    productId : productId
                },
                dataType : "text",
                success : function(data) {
                    if (data == "success") {
                        window.location.href = "<%=SystemConst.BASE_PATH%>admin/products/delProduct?productId=" + productId + "&pageNo=" + pageNo + "&pageSize=" + pageSize + "&" + $("#productForm").serialize();
                    } else {
                        swal({
                            title : data,
                            type : "warning",
                            confirmButtonColor : "#428bca",
                            confirmButtonText : "确定"
                        })
                    }
                }
            })
        });
    }

    function batchDel() {
        var sel = $(grid_selector).jqGrid("getGridParam", "selarrrow");
        var selIds = new Array();
        if (sel.length) {
            swal({
                title:'确认删除这些产品?',
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定",
                closeOnConfirm: false
            },function(){
                for (var i=0;i<sel.length;i++) {
                    selIds.push(sel[i]);
                    window.location.href="<%=SystemConst.BASE_PATH%>admin/products/delProduct?productIds="+selIds + "&" + $("#productForm").serialize();
                }
            });
        } else {
            swal({
                title:'请选择产品',
                type: "warning",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定"
            });
        }
    }
</script>
</body>
</html>
