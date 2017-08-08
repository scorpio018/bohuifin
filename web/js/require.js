/**
 * 
 */
function showRequire(questionId, deptId, obj, requireType, path) {
	BootstrapDialog.show({
		title : obj.text + '理由',
		message : /*function(dialogRef) {
			$.ajax({
				url : '<%=SystemConst.BASE_PATH%>require/submitQueNotOpen',
				type : "POST",
				data : {
					"questionId" : questionId,
					"requireType" : requireType
				},
				success : function(data) {
					return "<div>" + data + "</div>";
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					document.write(XMLHttpRequest.responseText);
				}
			})
		},*/ 
		$('<div></div>').load('require/submitQueNotOpen?questionId=' + questionId + '&requireType=' + requireType, 
			function(XMLHttpRequest, textStatus, errorThrown) {
			console.log(textStatus);
			if (textStatus != "success") {
				document.write(XMLHttpRequest.responseText);
			}
		}),
		buttons : [{
			label : '确定',
			cssClass : 'btn-primary',

			action : function() {
//				var reason='';
				var page=$(grid_selector).jqGrid("getGridParam", "page");
				var rowNum=$(grid_selector).jqGrid("getGridParam", "rowNum");
				var rec=$(grid_selector).find("tr").not(".jqgfirstrow").length;
				var pageInfo="?pageNo="+page+"&pageSize="+rowNum;
				var isRep=$(grid_selector).jqGrid("getGridParam", "postData").isReply;
				if (isRep==0 || isRep==1) {
					pageInfo+=pageInfo+"&isReply="+isRep;
				}
				/*if ($("input[name='form-field-radio']").length>0) {
					reason = $("input[name='form-field-radio']:checked").val();
				} else {
					reason=$("#reasonHidden").val();
				}
				if (reason != '正常删除' && reason!='涉诉及缠访，敏感问题' && reason!='超范围留言') {
					reason = $("#reason").val();
					if (reason == '' || reason == null) {
						swal({
							title : '请填写' + obj.text + '理由',
							type : "warning",
							confirmButtonColor : "#428bca",
							confirmButtonText : "确定"
						});
						return;
					}
				}*/
				$.ajax({
					url : "require/saveQueNotOpen",
					type : "POST",
					data : {
						"questionId" : questionId,
						"title" : $("#title").val(),
						"reason" : $("#reason").val(),
						"requireType" : $("#requireType").val()
					},
					dataType : "text",
					success : function(data) {
						alert(data);
						if (data == "success") {
							window.location.href = path + pageInfo;
						} else {
							swal({
								title : data,
								type : "error",
								confirmButtonColor : "#428bca",
								confirmButtonText : "确定"
							});
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