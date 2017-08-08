/**
 * 
 */
function showLayer(questionId, deptId, obj,path,basePath) {
	BootstrapDialog.show({
		title : obj.text + '理由',
		message : $('<div></div>').load('question/reason?reason=' + obj.text),
		buttons : [{
			label : '确定',
			cssClass : 'btn-primary',
			
			action : function() {
				var reason='';
				var page=$(grid_selector).jqGrid("getGridParam", "page");
				var rowNum=$(grid_selector).jqGrid("getGridParam", "rowNum");
				var rec=$(grid_selector).find("tr").not(".jqgfirstrow").length;
				if (page>1) {
					if (rec==1) {
						page=page-1;
					}
				}
				var pageInfo="&pageNo="+page+"&pageSize="+rowNum;
				var isRep=$(grid_selector).jqGrid("getGridParam", "postData").isReply;
				if (isRep==0 || isRep==1) {
					pageInfo+=pageInfo+"&isReply="+isRep;
				}
				if ($("input[name='form-field-radio']").length>0) {
					reason = $("input[name='form-field-radio']:checked").val();
				} else {
					reason=$("#reasonHidden").val();
				}
				reason=reason.trim();
				if (reason != '正常删除' && reason!='涉诉及缠访，敏感问题' && reason!='超范围留言') {
					reason = $("#reason").val();
					if (obj.text!="通过" && (reason == '' || reason == null)) {
						swal({
							title : '请填写' + obj.text + '理由',
							type : "warning",
							confirmButtonColor : "#428bca",
							confirmButtonText : "确定"
						});
						return;
					}
				}
				//删除
				if ($("input[name='form-field-radio']").length>0) {
					window.location.href = basePath+"question/logicDeleteQuestion?path="+path+"&questionId="+ questionId+ "&deptId="+ deptId+ "&reason=" + reason+pageInfo;
				//退回
				} else if ($("#reasonHidden").val()=='退回'){
					window.location.href=basePath+"question/sendBack?path="+path+"&questionId="+questionId+"&deptId="+deptId+"&reason="+reason+pageInfo;
				} else if ($("#reasonHidden").val()=='通过') {
					window.location.href=basePath+"question/pass?path="+path+"&questionId="+questionId+"&deptId="+deptId+"&delegateContent="+reason+pageInfo;
				}
			}
		}, {
				label : '关闭',
				action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
}

function showDelLayer(questionId,text,path,pageNo,pageSize,basePath) {
	BootstrapDialog.show({
		title : text + '理由',
		message : $('<div></div>').load('question/reason?reason=' + text),
		buttons : [{
			label : '确定',
			cssClass : 'btn-primary',

			action : function() {
				var reason='';
				var pageInfo="&pageNo="+pageNo+"&pageSize="+pageSize;
				if ($("input[name='form-field-radio']").length>0) {
					reason = $("input[name='form-field-radio']:checked").val();
				} else {
					reason=$("#reasonHidden").val();
				}
				if (reason != '正常删除' && reason!='涉诉及缠访，敏感问题' && reason!='超范围留言') {
					reason = $("#reason").val();
					if (reason == '' || reason == null) {
						swal({
							title : '请填写' + text + '理由',
							type : "warning",
							confirmButtonColor : "#428bca",
							confirmButtonText : "确定"
						});
						return;
					}
				}
				//删除
				window.location.href = "question/logicDeleteQuestion?path="+path+"&questionId="+ questionId+ "&reason=" + reason+pageInfo;
			}
		}, {
				label : '关闭',
				action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
}