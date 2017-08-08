<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<!DOCTYPE HTML">
<html>
<head>
<base href="<%=SystemConst.BASE_PATH%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><%=SystemConst.SYSTEM_NAME%></title>
<link rel="stylesheet" href="js/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="js/assets/css/font-awesome.min.css" />
<link rel="stylesheet" href="js/assets/css/ace.min.css" />
<link rel="stylesheet" href="js/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="js/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="css/style.css" />
<script src="js/assets/js/ace-extra.min.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body style="background-color:white;">
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->

				<div class="error-container">
					<div class="well">
						<h1 class="grey lighter smaller">
							<span class="blue bigger-125 ziti"> <i class="icon-sitemap"></i>
								400
							</span> <span class="ziti">您提交的数据不正确</span>
						</h1>

						<hr />
						<h3 class="lighter smaller">请你确认数据并再次提交</h3>

						<div style="display:none;">
							<form class="form-search">
								<span class="input-icon align-middle"> <i
									class="icon-search"></i> <input type="text"
									class="search-query" placeholder="Give it a search..." />
								</span>
								<button class="btn btn-sm" onclick="return false;">Go!</button>
							</form>

							<div class="space"></div>
							<h4 class="smaller">Try one of the following:</h4>

							<ul class="list-unstyled spaced inline bigger-110 margin-15">
								<li><i class="icon-hand-right blue"></i> Re-check the url
									for typos</li>

								<li><i class="icon-hand-right blue"></i> Read the faq</li>

								<li><i class="icon-hand-right blue"></i> Tell us about it</li>
							</ul>
						</div>

						<hr />
						<div class="space"></div>

						<div class="center">
							<a href="javascript:void(0);" class="btn btn-grey"
								onclick="window.history.back();"> <i class="icon-arrow-left"></i>
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
