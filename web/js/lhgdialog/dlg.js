/**
 * 根据使用者传入的最小宽、高，想要获得的窗口比例，以及最大宽高
 * 获得在当前页面弹出窗口的合适尺寸对象
 * @liu wenzhi 20150203
 */
function getDlgSize(minWidth, minHeight, scale, maxWidth, maxHeight){
    scale = scale || 0.8;
    var baseHeight = $(document).innerHeight(), baseWidth = $(document).innerWidth();
    if(document.documentElement){
    	//处理当页面出现滚动条时，$(document).innerHeight()取值包含滚动条高度的问题
    	if(document.documentElement.clientHeight < document.documentElement.offsetHeight-10){
    		baseHeight = document.documentElement.clientHeight;
    	}
    }
    var result = new Object();
    var tempWidth = baseWidth*scale,tempHeight = baseHeight*scale;
    tempWidth = tempWidth < minWidth ? minWidth : tempWidth;
    tempHeight = tempHeight < minHeight ? minHeight : tempHeight;
    if(maxWidth){
        tempWidth = tempWidth > maxWidth ? maxWidth : tempWidth;
    }
    if(maxHeight){
        tempHeight = tempHeight > maxHeight ? maxHeight :tempHeight;
    }
    result.width = parseInt(tempWidth);
    result.height = parseInt(tempHeight);
    return result;
}

function getRateSize(wrate, hrate){
	wrate = wrate || 0.8;
	hrate = hrate || 0.8;
	var baseHeight = $(document).innerHeight(), baseWidth = $(document).innerWidth();
    if(document.documentElement){
    	//处理当页面出现滚动条时，$(document).innerHeight()取值包含滚动条高度的问题
    	if(document.documentElement.clientHeight < document.documentElement.offsetHeight-10){
    		baseHeight = document.documentElement.clientHeight;
    	}
    }
    return {
    	width : parseInt(baseWidth * wrate),
    	height : parseInt(baseHeight * hrate)
    }
}