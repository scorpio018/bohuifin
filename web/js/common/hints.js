/**
 * 出现错误时调用的错误框
 * @param data 提示信息
 */
function errorAlert(data) {
	swal({
		title : "出错啦",
		text : data,
		type : "error",
		confirmButtonColor : "#428bca",
		confirmButtonText : "确定"
	});
}

/**
 * 成功后调用的提示框
 * @param title 标题
 * @param text 提示信息
 * @param isSubmit 是否需要提交表单，true:需要;false:不需要
 */
function successAlert(title, text, isSubmit) {
	swal({
		title : title,
		text : text,
		type : "success",
		confirmButtonText : "确定"
	},
	function() {
		if (isSubmit) {
			$("form").submit();
		}
	})
}

function successAlertAndRefresh(title, text) {
	swal({
		title : title,
		text : text,
		type : "success",
		confirmButtonText : "确定"
	},
	function(isConfirm){
		location.reload();
	})
}