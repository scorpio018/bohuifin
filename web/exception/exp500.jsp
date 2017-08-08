<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=SystemConst.BASE_PATH%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><%=SystemConst.SYSTEM_NAME%></title>
<link rel="stylesheet" href="js/assets/css/jquery-ui-1.10.3.full.min.css" />
<link rel="stylesheet" href="js/assets/css/chosen.css" />
<link rel="stylesheet" href="js/assets/css/datepicker.css" />
<link rel="stylesheet" href="js/assets/css/ui.jqgrid.css" />
<link rel="stylesheet" href="js/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="js/assets/css/font-awesome.min.css" />
<link rel="stylesheet" href="js/assets/css/ace.min.css" />
<link rel="stylesheet" href="js/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="js/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript">
	function showErr() {
		var state = document.getElementById("err").style.display;
		state = state=='inline'?'none':'inline';
		document.getElementById("err").style.display=state;
	}
</script>
</head>

<body style="background-color:white;">
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->

				<div class="error-container">
					<div class="well">
						<h1 class="grey lighter smaller">
							<span class="blue bigger-125 ziti"> <i class="icon-random"></i>
							</span> <span class="ziti">系统提示</span>
							<i class="icon-wrench icon-animated-wrench bigger-125"></i>

						</h1>

						<hr />
						<h3 class="lighter smaller">
							<span class="ziti">${exception.message}</span> 
						</h3>
						<a class="ziti" href="javascript:void(0);" onclick="showErr();">点击查看错误信息</a>
						<div class="space"></div>
						<div id="err" style="display:none;">
								<c:forEach items="${exception.stackTrace }" var="e">
									${e}<br>
								</c:forEach>
						</div>
						<div class="space"></div>
						<hr />
						<div class="space"></div>

						<div class="center">
							<a href="javascript:history.go(-1);" class="btn btn-grey" > <i class="icon-arrow-left"></i>
								<span class="ziti">返回</span>
							</a> 
						</div>
					</div>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->
</body>
</html>
