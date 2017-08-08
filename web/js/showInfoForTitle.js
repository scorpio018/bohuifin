function search(basePath) {
	var title = document.getElementById("title");
	var str = encodeURI(encodeURI(title.value));
	window.open(basePath + "www/info/newest.true.40?title=" + str);
}