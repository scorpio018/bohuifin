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
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace.min.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.css" />
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>css/style.css" />
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/chosen.jquery.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/function.js"></script>
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
                                <span class="ziti">关键字：</span><input type="text" id="keyword" value="${requestScope.keyword}"
                                                                     placeholder="按操作员名或者真实姓名查询" style="width:200px;" class="ziti">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="button" class="btn btn-sm btn-primary"
                                        style="height:28px;" onclick="search();">
                                    <p class="ziti" style="margin-top:-3px;">查询</p>
                                </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="javascript:void(0)" class="btn btn-sm btn-primary" style="height:28px;" onclick="add();">
                                    <p class="ziti" style="margin-top:-3px;">新建评论</p>
                                </a>&nbsp;&nbsp;
                                <a href="javascript:void(0);" class="btn btn-sm btn-primary" style="height:28px;" onclick="batchDel();">
                                    <p class="ziti" style="margin-top:-3px;">批量删除</p>
                                </a>
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
            url : "admin/dealertalk/dealerTalkData",
            contentType : 'application/json',
            datatype : "json",
            postData : {
                keyword : $("#keyword").val()
            },
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
            colNames : ['交易员留言编号','操作员名','真实姓名', '产品名', '交易员留言', '发布时间','操作'],
            colModel : [
                {name:'talkId',index:'dt.talk_id', width:40,key:true,align:'center'},
                {name:'dealerBean.dealerName',index:'d.dealer_name', width:40,align:'center'},
                {name:'dealerBean.trueName',index:'d.true_name', width:45,align:'center'},
                {name:'productBean.productName',index:'p.nick_name', width:45,align:'center'},
                {name:'talkContent',index:'dt.talk_content', width:45,align:'center'},
                {name:'createTime',index:'dt.create_time', width:45,align:'center',
                    formatter: function (cellvalue, options, rowObject) {
                        var tmp = new Date(cellvalue).format("yyyy-MM-dd hh:mm:ss");
                        return tmp;
                    }},
                {name:'talkId',index:'dt.talk_id', width:240, fixed:true,resize:false,title:false,sortable:false,align:'center',
                    formatter : function(cellvalue, options, rowObject) {
                        var tmp="<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>";
                        tmp += "<a href='javascript:void(0);' onclick='edit("+cellvalue+")' title='编辑' >编辑</a> ";
                        tmp += "<a href='javascript:void(0);' onclick='del(\""+cellvalue+"\", \"" + rowObject.dealerName + "\");' title='删除' >删除</a>";
                        return tmp+"</div>";
                    }
                }
            ],
            multiselect: true,
            multiboxonly: true,
            caption : "交易员留言列表",
            autowidth : true,

        });
    }

    setInterval("resizeaa()",10);

    function edit(talkId) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        var keyword = $("#keyword").val();
        window.location.href="<%=SystemConst.BASE_PATH%>admin/dealertalk/showAddDealerTalk?talkId=" + talkId + "&pageNo="+pageNo+"&pageSize="+pageSize + "&act=edit&keyword=" + keyword;
    }

    function resizeaa() {
        $(grid_selector).jqGrid('setGridWidth', $("#responsive").width());
    }

    function search() {
        $(grid_selector).setGridParam({
            page:1,
            postData : {
                keyword : $("#keyword").val()
            }
        }).trigger("reloadGrid");
    }

    function add() {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        var keyword = $("#keyword").val();
        window.location.href = "<%=SystemConst.BASE_PATH%>admin/dealertalk/showAddDealerTalk?pageNo="+pageNo+"&pageSize="+pageSize + "&act=add&keyword=" + keyword;
    }

    function del(talkId) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        var keyword = $("#keyword").val();
        swal({
            title : "确认删除此交易员留言?",
            type : "warning",
            showCancelButton : true,
            cancelButtonText : "取消",
            confirmButtonColor : "#428bca",
            confirmButtonText : "确定",
            closeOnConfirm : false
        },function(){
            $.ajax({
                url : "admin/dealertalk/beforeDel",
                type : "POST",
                data : {
                    talkId : talkId
                },
                dataType : "text",
                success : function(data) {
                    if (data == "success") {
                        window.location.href = "<%=SystemConst.BASE_PATH%>admin/dealertalk/delDealerTalk?talkId=" + talkId + "&pageNo=" + pageNo + "&pageSize=" + pageSize + "&keyword=" + keyword;
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
        var keyword = $("#keyword").val();
        var sel = $(grid_selector).jqGrid("getGridParam", "selarrrow");
        var selIds = new Array();
        if (sel.length) {
            swal({
                title:'确认删除这些交易员留言?',
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定",
                closeOnConfirm: false
            },function(){
                for (var i=0;i<sel.length;i++) {
                    selIds.push(sel[i]);
                    window.location.href="<%=SystemConst.BASE_PATH%>admin/dealertalk/delDealerTalk?talkIds="+selIds + "&keyword=" + keyword;
                }
            });
        } else {
            swal({
                title:'请选择交易员留言',
                type: "warning",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定"
            });
        }
    }
</script>
</body>
</html>
