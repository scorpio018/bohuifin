/**
 * Created by Administrator on 2017/7/10 0010.
 */
$().ready(function () {
    var before_change = function(files, dropped) {
        var allowed_files = [];
        console.log("before_change length:" + files.length);
        for(var i = 0 ; i < files.length; i++) {
            var file = files[i];
            if(typeof file === "string") {
                //IE8 and browsers that don't support File Object
                if(! (/\.(jpe?g|png|gif|bmp)$/i).test(file) ) {
                    alert("请上传图片格式的文件");
                    return false;
                }
            }
            else {
                var type = $.trim(file.type);
                if( ( type.length > 0 && ! (/^image\/(jpe?g|png|gif|bmp)$/i).test(type) )
                    || ( type.length == 0 && ! (/\.(jpe?g|png|gif|bmp)$/i).test(file.name) )//for android's default browser which gives an empty string for file.type
                ) continue;//not an image so don't keep this file
            }

            allowed_files.push(file);
        }
        if(allowed_files.length == 0) {
            alert("请上传图片");
            return false;
        }
        return allowed_files;
    };
    var btn_choose = "将图片拖入此处或点击上传";
    var no_icon = "icon-picture";

    $('#input-file-img').ace_file_input({
        style:'well',
        btn_choose:'将图片拖入此处或点击上传',
        btn_change:null,
        no_icon:'icon-cloud-upload',
        droppable:true,
        thumbnail:'small',//large | fit
        before_change: before_change
        //,icon_remove:null//set null, to hide remove/reset button
        /**,before_remove : function() {
						return true;
					}*/
        ,
        preview_error : function(filename, error_code) {
            //name of the file that failed
            //error_code values
            //1 = 'FILE_LOAD_FAILED',
            //2 = 'IMAGE_LOAD_FAILED',
            //3 = 'THUMBNAIL_FAILED'
            //alert(error_code);
        }

    }).on('change', function(){
        //console.log($(this).data('ace_input_files'));
        //console.log($(this).data('ace_input_method'));
    });

    $('#input-file').ace_file_input({
        style:'well',
        btn_choose:'将图片拖入此处或点击上传',
        btn_change:null,
        no_icon:'icon-cloud-upload',
        droppable:true,
        thumbnail:'small',//large | fit
        before_change: function (files, dropped) {
            return files;
        }
        //,icon_remove:null//set null, to hide remove/reset button
        /**,before_remove : function() {
						return true;
					}*/
        ,
        preview_error : function(filename, error_code) {
            //name of the file that failed
            //error_code values
            //1 = 'FILE_LOAD_FAILED',
            //2 = 'IMAGE_LOAD_FAILED',
            //3 = 'THUMBNAIL_FAILED'
            //alert(error_code);
        }

    }).on('change', function(){
        //console.log($(this).data('ace_input_files'));
        //console.log($(this).data('ace_input_method'));
    });
    /*$('#spinner1').ace_spinner({value:0,min:0,max:200,step:10, btn_up_class:'btn-info' , btn_down_class:'btn-info'})
        .on('change', function(){
            //alert(this.value)
        });
    $('#spinner2').ace_spinner({value:0,min:0,max:10000,step:100, touch_spinner: true, icon_up:'icon-caret-up', icon_down:'icon-caret-down'});
    $('#spinner3').ace_spinner({value:0,min:-100,max:100,step:10, on_sides: true, icon_up:'icon-plus smaller-75', icon_down:'icon-minus smaller-75', btn_up_class:'btn-success' , btn_down_class:'btn-danger'});*/
})