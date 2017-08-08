/**
 * 用于加载部门树，该部门树加载当前传入的部门ID对应的所有下级全部部门，返回选中的部门ID
 * @param basePath 网站的跟路径
 * @param deptId 部门ID
 */
function showDeptTree(basePath, deptId) {
	var dg = new J.dialog({
		title : "选择部门树",
		autoPos : {
			left : 'center',
			top : 'center'
		},
		cover : true,
		width : 600,
		height : 400,
		page : basePath + "dept/showDeptTree?deptId=" + deptId,
		btnBar : false
	});
	dg.ShowDialog();
}

//定义了一个集合
var setting = {
	check: {
		enable: true
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	view: {
		showLine : false
	},
	callback : {
		beforeClick : function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("deptAcceptReportTree");
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
			}
		},
		onExpand : zTreeOnExpand
	}
};

function zTreeOnExpand(event, treeId, treeNode) {
	$("#deptAcceptReportTree").scrollTop(document.getElementById(treeNode.tId).offsetTop - 24);
};

function setCheck(treeName) {
	var zTree = $.fn.zTree.getZTreeObj(treeName),
	py = "p",
	sy = "s",
	pn = "p",
	sn = "s",
	type = { "Y":py + sy, "N":pn + sn};
	type = { "Y" : "", "N" : ""};
	zTree.setting.check.chkboxType = type;
}

//对公司单位树的初始化函数
function zNodeInit($deptInfos) {
	//json字符串转换为对象
	//调用函数生成树
	$.fn.zTree.init(jQuery("#deptAcceptReportTree"), setting, zNodes);
	setCheck("deptAcceptReportTree");
}

var flag = false;

function showDeptTree(questionId) {
	BootstrapDialog.show({
		title : '选择信息种类',
		message : function(dialogRef) {
			return $("#deptAcceptReportTree");
		},
		onhide : function(dialogRef) {
			$("#deptAcceptReportTreeHid").html(dialogRef.getMessage());
			dialogRef.close();
		},
		buttons : [{
			label : '确定',
			cssClass : 'btn-primary',
			hotkey : 13, // Enter.
			action : function(dialogItself) {
				var treeDept = $.fn.zTree.getZTreeObj("deptAcceptReportTree");
				var nodesDept = treeDept.getCheckedNodes(true);
				if (nodesDept.length > 0) {
					var strDeptId = "";
					if (nodesDept.length == 1) {
						strDeptId += nodesDept[0].id;
					} else {
						for (var i = 0; i < nodesDept.length; i ++) {
							strDeptId += nodesDept[i].id;
							if (nodesDept.length != i + 1) {
								strDeptId += ",";
							}
						}
					}
					$.ajax({
						url : "report/submitQuestion",
						type : "POST",
						data : {
							"questionId" : questionId,
							"deptIds" : strDeptId
						},
						dataType : "text",
						success : function(data) {
							if (data == "success") {
								successAlertAndRefresh("报送成功", "报送的部门将能实时看到办件的状态并予以批示");
								/*$("#deptAcceptReportTreeHid").html(dialogItself.getMessage());
								dialogItself.close();*/
							}
						}, error : function(XMLHttpRequest, textStatus, errorThrown) {
							document.write(XMLHttpRequest.responseText);
						}
					})
					/*$("#deptIds").val(strDeptId);
					$("#infoDirsDisabled").attr("title", strDeptName);
					$("#infoDirsDisabled").val(strDeptName);
					$("#deptCode").val(deptCode);*/
						
				}
			}
		}, {
				label : '关闭',
				action : function(dialogItself) {
					$("#deptAcceptReportTreeHid").html(dialogItself.getMessage());
					dialogItself.close();
				}
		}]
	});
}