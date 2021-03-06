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
                                <span class="ziti">关键字：</span><input type="text" id="keyword" value="${requestScope.keyword}"
                                                                     placeholder="按用户名或者真实姓名查询" style="width:200px;" class="ziti">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="button" class="btn btn-sm btn-primary"
                                        style="height:28px;" onclick="search();">
                                    <p class="ziti" style="margin-top:-3px;">查询</p>
                                </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="javascript:void(0)" class="btn btn-sm btn-primary" style="height:28px;" onclick="add();">
                                    <p class="ziti" style="margin-top:-3px;">新建用户</p>
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
            url : "admin/users/userData",
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
            colNames : ['用户编号','用户名','真实姓名', '昵称', '排序','操作'],
            colModel : [
                {name:'userId',index:'user_id', width:40,key:true,align:'center'},
                {name:'userName',index:'user_name', width:40,align:'center'},
                {name:'trueName',index:'true_name', width:45,align:'center'},
                {name:'nickName',index:'nick_name', width:45,align:'center'},
                {name:'listOrder',index:'list_order', width:20,align:'center'},
                {name:'userId',index:'user_id', width:240, fixed:true,resize:false,title:false,sortable:false,
                    formatter : function(cellvalue, options, rowObject) {
                        var tmp="<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>";
                        tmp += "<a href='javascript:void(0);' onclick='initpwd("+cellvalue+");' title='初始化密码' >初始化密码</a> ";
                        tmp += "<a href='javascript:void(0);' onclick='edit("+cellvalue+")' title='编辑' >编辑</a> ";
                        tmp += "<a href='javascript:void(0);' onclick='del(\""+cellvalue+"\", \"" + rowObject.userName + "\");' title='删除' >删除</a>";
                        return tmp+"</div>";
                    }
                }
            ],
            multiselect: true,
            multiboxonly: true,
            caption : "用户列表",
            autowidth : true,

        });
    }

    setInterval("resizeaa()",10);

    function initpwd(userId) {
        $.ajax({
            url : "admin/users/initpwd",
            type : "POST",
            data : {
                userId : userId
            },
            dataType : "json",
            success : function(data) {
                var code = data.code;
                if (code == 0) {
                    swal({
                        title: "系统提示",
                        text: '初始化密码完毕,新密码为:<h1>' + data.resultMsg+'</h1>',
                        type: "success",
                        confirmButtonText: "确定" ,
                        confirmButtonColor: "#428bca",
                        html:true
                    });
                } else {
                    swal({
                        title : data.errorMsg,
                        type : "warning",
                        confirmButtonColor : "#428bca",
                        confirmButtonText : "确定"
                    })
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                document.write(XMLHttpRequest.responseText);
            }
        });
    }

    function edit(userId) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        var keyword = $("#keyword").val();
        window.location.href="<%=SystemConst.BASE_PATH%>admin/users/showAddUser?userId=" + userId + "&pageNo="+pageNo+"&pageSize="+pageSize + "&act=edit&keyword=" + keyword;
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
        window.location.href = "<%=SystemConst.BASE_PATH%>admin/users/showAddUser?pageNo="+pageNo+"&pageSize="+pageSize + "&act=add&keyword=" + keyword;
    }

    function del(userId, userName) {
        var pageNo = $(grid_selector).jqGrid("getGridParam", "page");
        var pageSize = $(grid_selector).jqGrid("getGridParam", "rowNum");
        var keyword = $("#keyword").val();
        swal({
            title : "确认删除【" + userName + "】?",
            type : "warning",
            showCancelButton : true,
            cancelButtonText : "取消",
            confirmButtonColor : "#428bca",
            confirmButtonText : "确定",
            closeOnConfirm : false
        },function(){
            $.ajax({
                url : "users/beforeDel",
                type : "POST",
                data : {
                    userId : userId
                },
                dataType : "text",
                success : function(data) {
                    if (data == "success") {
                        window.location.href = "<%=SystemConst.BASE_PATH%>admin/users/delUser?userId=" + userId + "&pageNo=" + pageNo + "&pageSize=" + pageSize + "&keyword=" + keyword;
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
                title:'确认删除这些用户?',
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定",
                closeOnConfirm: false
            },function(){
                for (var i=0;i<sel.length;i++) {
                    selIds.push(sel[i]);
                    window.location.href="<%=SystemConst.BASE_PATH%>admin/users/delUser?userIds="+selIds + "&keyword=" + keyword;
                }
            });
        } else {
            swal({
                title:'请选择用户',
                type: "warning",
                confirmButtonColor: "#428bca",
                confirmButtonText: "确定"
            });
        }
    }
</script>
</body>
</html>
