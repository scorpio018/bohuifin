var width = -1;
$().ready(function() {
	var $iframeFirst = $("iframe").first();
	var top = $iframeFirst.css("height");
	$(".sidebar").css("top", top);
	var $iframeLast = $("iframe").last();
	var height = $iframeLast.offset().top;
	if (top.indexOf("px") != -1) {
		top = parseInt(top.substring(0, top.length - 2));
	}
	height = height - top;
	$(".sidebar").css("height", height + "px");
	var $iframeSideBar = $(".sidebar").find("iframe");
	if ($iframeSideBar != undefined) {
		$iframeSideBar.css("height", height + "px");
	}
})

function getWidth($obj) {
	if (width != -1) {
		
	} else {
		width = $obj.css("width");
		if (width.indexOf("px") != -1) {
			width = parseInt(width.substring(0, width.length - 2));
		}
	}
}