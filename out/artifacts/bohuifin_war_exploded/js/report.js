/**
 * 
 */
function showReport(reportId, title, deptId, url, isRefresh) {
	BootstrapDialog.show({
		title : "对办件的批示内容",
		message : $('<div></div>').load('report/commentReport?reportId=' + reportId, 
		function(XMLHttpRequest, textStatus, errorThrown) {
			if (textStatus != "success") {
				document.write(XMLHttpRequest.responseText);
			}
		}),
		buttons : [{
			label : '确定',
			cssClass : 'btn-primary',
		
			action : function(dialogItself) {
				$.ajax({
					url : "report/saveCommentReport",
					type : "POST",
					data : {
						"reportId" : reportId,
						"answerContent" : $("#answerContent").val()
					},
					dataType : "text",
					success : function(data) {
						if (data == "success") {
							successAlert("批示成功", "可查看该办件的用户将会收到该批示", false);
							swal({
								title : "批示成功",
								text : "可查看该办件的用户将会受到该批示",
								type : "success",
								confirmButtonText : "确定"
							},function() {
								if (isRefresh) {
									var page=$(grid_selector).jqGrid("getGridParam", "page");
									var rowNum=$(grid_selector).jqGrid("getGridParam", "rowNum");
									window.location.href = url + "?deptId=" + deptId + "&pageNo="+page+"&pageSize="+rowNum;
								}
							});
						} else {
							errorAlert(data);
							dialogItself.close();
							/*swal({
								title : data,
								type : "error",
								confirmButtonColor : "#428bca",
								confirmButtonText : "确定"
							});*/
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						document.write(XMLHttpRequest.responseText);
					}
				})
			}
		}, {
				label : '关闭',
				action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
}