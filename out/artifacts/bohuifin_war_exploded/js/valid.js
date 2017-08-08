
function changeCode() {
        $(".yzm_xf").attr("src","http://zw.tjdpf.org.cn/msg/entry/identifyingCode?"+ Math.floor(Math.random()*100));
}

function chkIsTel(str)
{
    var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
    
    return patrn.test(str);
}

function chkIsEmail(str)
{
	var re = new RegExp(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/);
	return re.test(str);
}

function sel(obj) {
$("#iddrive").val($(obj).val());
}

function check() {
 if ($("#iptname").val().length==0) {
   alert('请输入姓名');
   $("#iptname").focus();
   return false;
 }
 if ($("#iptphone").val().length==0) {
     alert('请输入联系电话');
     $("#iptphone").focus();
	 return false;
 }
 if($("#iptid").val()=="身份证"){
	 if($("#iptnum").val().length!=18){
		 alert('请正确输入身份证号');
		 $("#iptnum").focus();
		 return false;
	 }
 }else if($("#iptid").val()=="残疾人证"){
	 if($("#iptnum").val().length!=20){
		 alert('请正确输入残疾人证号');
		 $("#iptnum").focus();
		 return false;
	 }
 }
 if (!chkIsTel($("#iptphone").val()) || $("#iptphone").val().length<7) {
    alert("联系电话格式不正确！");
    $("#iptphone").focus();
    return false;
 }
  if ($("#iptmail").val().length==0) {
     alert('请输入电子邮件');
     $("#iptmail").focus();
	 return false;
 }
 if (!chkIsEmail($("#iptmail").val())) {
    alert("电子邮件格式不正确！");
    $("#iptmail").focus();
    return false;
 }
 if ($("#ipttitle").val().length==0) {
     alert('请输入问题标题');
     $("#ipttitle").focus();
	 return false;
 } else if ($("#ipttitle").val().length<10) {
     alert('问题标题过短');
     $("#ipttitle").focus();
	 return false;
 } else if ($("#ipttitle").val().length>25) {
     alert('问题标题过长');
     $("#ipttitle").focus();
	 return false;
 }
 if ($("#iptproblem").val().length==0) {
	alert('请输入问题内容');
	$("#iptproblem").focus();
	return false;
 } else if ($("#iptproblem").val().length>600) {
    alert('问题内容超长');
    $("#iptproblem").focus();
	return false;
 }
 if ($("#ipt_yzm").val().length==0) {
   alert('请输入验证码');
   $("#ipt_yzm").focus();
   return false;
 }
}