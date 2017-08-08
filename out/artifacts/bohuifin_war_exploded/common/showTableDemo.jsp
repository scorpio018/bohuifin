<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix= 'fmt' uri ="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=SystemConst.BASE_PATH%>">

<title><%=SystemConst.SYSTEM_NAME%></title>
<%@include file="/common/common.jsp"%>
<%@include file="/common/showTablePage.jsp"%>
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.css" />
<script src="<%=SystemConst.BASE_PATH%>js/function.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/sweetAlert/sweet-alert.min.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/common/hints.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/question.js"></script>
<script type="text/javascript" src="<%=SystemConst.BASE_PATH%>js/report.js"></script>
<script type="text/javascript">
	$().ready(function() {
		<c:if test="${requestScope.errorCode ne null}">
			swal({
				title : "${requestScope.errorCode}",
				type : "warning",
				confirmButtonColor : "#428bca",
				confirmButtonText : "确定"
			})
		</c:if>
		initAjax();
		init();
		//tooltips
	})
	
	setInterval("resizeaa()",10);
	
	function resizeaa() {
		 $(grid_selector).jqGrid('setGridWidth', $("#responsive").width());
	}
	
	function initAjax() {
		jQuery(grid_selector).jqGrid({
			url : "<%=SystemConst.BASE_PATH%>report/loadReportData",  
			mtype: "POST",
			contentType : 'application/json',
			datatype: "json",
			postData: {
				"deptId" : "${requestScope.deptVo.deptId}",
				"pageNo" : "${requestScope.page.pageNo}",
				"pageSize" : "${requestScope.page.pageSize}"
			},
			jsonReader:{total:"totalPage",root:"results",records:"totalRecord"},
			prmNames : {rows:"pageSize",page:"pageNo"},
			height: "auto",
			viewrecords : true,
			rowNum:'${requestScope.page.pageSize}',
			page:'${requestScope.page.pageNo}',
			rowList:[5,10,15,20,30],
			pager : pager_selector,
			altRows: false,
			emptyrecords:"无可用数据",
			//toppager: true,
			
			multiselect: false,
	        multiboxonly: true,
	        loadError:function(xhr,status,error){
				document.write(xhr.responseText);
			},
			loadComplete : function() {
				$("#grid-table").closest("div.ui-jqgrid-view")
					.find(".ui-jqgrid-sortable")
					.css("text-align", "center");
				//$("#grid-table").closest("div.ui-jqgrid-view").find(".ui-jqgrid-titlebar").removeAttr("style");
				$("#grid-table").closest("div.ui-jqgrid-view")
					.find(".ui-jqgrid-titlebar")
					.css({
						"text-align": "center",
						"padding-top": "4.5px"
					})
					.find(".ui-jqgrid-title")
					.css({
						"float": "none"
					});
				
				var table = this;
				setTimeout(function(){
					styleCheckbox(table);
					
					updateActionIcons(table);
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			colModel:[
			{
				name : "questionId",
				index : "question_id",
				label : "办件编号",
				align : "center",
				width : 35,
				key : true
			},{
				name : "questionId",
				index : "question_id",
				label : "标题",
				align : "left",
				width : 80,
				formatter : function(cellvalue, options, rowObject) {
					var tmp = rowObject.questionVo.title;
					if (tmp.length > 18) {
						tmp = "<a href='javascript:void(0)' onclick='showDetail("+rowObject.questionId+")' alt=\"" + tmp + "\">" + tmp.substring(0,18) + "...</a>";
					} else {
						tmp = "<a href='javascript:void(0)' onclick='showDetail("+rowObject.questionId+")' alt=\"" + tmp + "\">" + tmp + "</a>";
					}
					return tmp;
				}
			},{
				name : "deptId",
				index : "dept_id",
				label : "报送单位",
				align : "center",
				width : 80,
				formatter : function(cellvalue, options, rowObject) {
					var tmp = rowObject.deptVo.deptName;
					if (tmp.length > 18) {
						tmp = "<span alt=\"" + tmp + "\">" + tmp.substring(0,18) + "...</span>";
					} else {
						tmp = "<span alt=\"" + tmp + "\">" + tmp + "</a>";
					}
					return tmp;
				}
			},{
				name : "questionId",
				index : "question_id",
				label : "办件状态",
				align : "center",
				width : 60,
				formatter : function(cellvalue, options, rowObject) {
					var tmp = parseInt(rowObject.questionVo.curState);
					if (tmp == "0") {
						tmp = "待答复";
					} else if (tmp == "1") {
						tmp = "已答复";
					} else if (tmp == "2") {
						tmp = "已删除";
					} else if (tmp == "3") {
						tmp = "待分拨";
					} else if (tmp == "4") {
						tmp = "待审核";
					} else if (tmp == "5") {
						tmp = "内部资料";
					} else if (tmp == "6") {
						tmp = "内参审核状态";
					} else if (tmp == "7") {
						tmp = "预审";
					} else {
						tmp = "未知";
					}
					return tmp;
				}
			},{
				name : "reportUserId",
				index : "report_user_id",
				label : "报送人",
				align : "center",
				width : 70,
				formatter : function(cellvalue, options, rowObject) {
					var tmp = rowObject.reportUserVo;
					if (tmp == null) {
						tmp = "<span style='color: #cccccc;'>已注销用户</span>";
					} else {
						tmp = tmp.truename;
					}
					return tmp;
				}
			},{
				name : "reportDate",
				index : "report_date",
				label : "报送日期",
				align : "center",
				width : 40,
				formatter : function(cellvalue, options, rowObject) {
					var tmp;
					if (cellvalue == null || cellvalue == "") {
						tmp = "-";
					} else {
						tmp = new Date(cellvalue).format("yyyy-MM-dd");
					}
					return tmp;
				}
			},{
				name : "answerDate",
				index : "answer_date",
				label : "批示日期",
				align : "center",
				width : 40,
				formatter : function(cellvalue, options, rowObject) {
					var tmp;
					if (cellvalue == null || cellvalue == "") {
						tmp = "-";
					} else {
						tmp = new Date(cellvalue).format("yyyy-MM-dd");
					}
					return tmp;
				}
			},{
				label : "操作",
				width : 40,
				align : "center",
				formatter : function(cellvalue, options, rowObject) {
					var tmp = "<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>";
					/* tmp += "<a href='report/commentReport?reportId=" + rowObject.reportId + "&deptId=${requestScope.deptVo.deptId}&pageNo=" + pageNo + "&pageSize=" + pageSize + "'>批示</a>|"; */
					<c:if test="${requestScope.isShowPassBtn}">
					var state = rowObject.questionVo.curState;
					console.log(state);
					if (state == 4) {
						tmp += "<a href='javascript:void(0)' onclick='showLayer(\"" + rowObject.questionVo.questionId + "\", \"${requestScope.deptVo.deptId}\", this, \"report/showReport\",\"<%=SystemConst.BASE_PATH%>\")'>通过</a>|";
					}
					</c:if>
					tmp += "<a href='javascript:void(0)' onclick='showReport(\"" + rowObject.reportId + "\", \"" + rowObject.questionVo.title + "\", \"${requestScope.deptVo.deptId}\", \"report/showReport\", \"true\")'>批示</a>|";
					/* tmp += "<a href='dept/delDept?deptId=" + rowObject.deptId + "&parentId=" + rowObject.parentId + "'>删除</a>"; */
					tmp += "<a href='javascript:void(0)' onclick='del(\"" + rowObject.reportId + "\")'>删除</a>";
					tmp += "</div>";
					return tmp;
				}
			}],
			//editurl: $path_base+"/dummy.html",//nothing is saved
			caption: "呈报信息列表",
			autowidth: true
		});
	}
	
	function showDetail(id) {
		var page=$(grid_selector).jqGrid("getGridParam", "page");
		var rowNum=$(grid_selector).jqGrid("getGridParam", "rowNum");
		window.location.href="<%=SystemConst.BASE_PATH%>question/detail?path=report/showReport&questionId="+id+ "&deptId=${requestScope.deptVo.deptId}&page="+page+"&pageNum="+rowNum;
	}
	
	/* function search() {
		$(grid_selector).setGridParam({page:1,postData: {title:$("#title").val()}}).trigger("reloadGrid");
	} */
	
	function del(reportId, deptId) {
		var pageNo=$(grid_selector).jqGrid("getGridParam", "page");
		var pageSize=$(grid_selector).jqGrid("getGridParam", "rowNum");
		swal({
			title : "确认删除此条数据?",
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "取消",
			confirmButtonColor : "#428bca",
			confirmButtonText : "确定",
			closeOnConfirm : false
		},function(){
			window.location.href = "<%=SystemConst.BASE_PATH%>report/delReport?reportId=" + reportId + "&deptId=${requestScope.deptVo.deptId}&pageNo=" + pageNo + "&pageSize=" + pageSize;
		});
	}
</script>
</head>

<body>
	<%@ include file="/common/deptBanner.jsp" %>
	
	<div class="main-container-inner">
		<div class="main-content">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<div class="row">
							<div class="col-xs-12">
								<div>
								</div>
								<br>
								<div class="table-responsive" id="responsive">
									<table id="grid-table"></table>
									<div id="grid-pager"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
