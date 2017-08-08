/**
 * 用于初始化编辑器
 * @param basePath 网站的跟路径
 * @param deptId 部门ID
 */
function editorInit(editorId) {
	$('#' + editorId).ace_wysiwyg({
		toolbar:[
			{name:'font',title:'字体',values: ["宋体", "黑体", "楷体", "隶书","微软雅黑","新宋体","幼圆","Arial","Comic Sans MS","Courier New", "Open Sans", "Tahoma", "Verdana"]},
			null,
			{name:'fontSize',title:'字号',values:{1:"1",2:"2",3:"3",4:"4",5:"5",6:"6",7:"7"}},
			null,
			{name:'bold', className:'btn-info',title:'加粗(Ctrl/Cmd+B)'},
			{name:'italic', className:'btn-info',title:'斜体(Ctrl/Cmd+I)'},
			{name:'strikethrough', className:'btn-info',title:'删除线'},
			{name:'underline', className:'btn-info',title:'下划线'},
			null,
			{name:'insertunorderedlist', className:'btn-success',title:'添加无序列表'},
			{name:'insertorderedlist', className:'btn-success',title:'添加有序列表'},
			{name:'outdent', className:'btn-purple',title:'撤销缩进(Shift+Tab)'},
			{name:'indent', className:'btn-purple',title:'缩进(Tab)'},
			null,
			{name:'justifyleft', className:'btn-primary',title:'左对齐(Ctrl/Cmd+L)'},
			{name:'justifycenter', className:'btn-primary',title:'中间对齐(Ctrl/Cmd+E)'},
			{name:'justifyright', className:'btn-primary',title:'右对齐(Ctrl/Cmd+R)'},
			{name:'justifyfull', className:'btn-inverse',title:'两端对齐(Ctrl/Cmd+J)'},
			null,
			null,
			null,
			null,
			null,
			null,
			{name:'foreColor',title:'前景色'},
			null,
			{name:'undo', className:'btn-grey',title:'撤销(Ctrl/Cmd+Z)'},
			{name:'redo', className:'btn-grey',title:'前进(Ctrl/Cmd+Y)'}
		],
		'wysiwyg': {
			fileUploadError: errorAlert
		}
	}).prev().addClass('wysiwyg-style2');
}

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