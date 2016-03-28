function imgUpload (fun){
    if($('.uploadBtn').length){
        $('.uploadBtn').each(function(key,value){
            var $this = $(this);
            var $par = $this.parents('.uploadModal');
           // window.ctx = '/supply';
          //  window.ctx
            var btn = $this,
                progressBar = $par.find('.progress-bar'),
                progressOuter = $par.find('.progress'),
                picBox = $par,
                addBtn = $par.find('.addBtn'),
                showModal = $par.find('.showModal'),
                img = $par.find('img');
            if(img.attr('src')!=""){
                $this.css('background-image','none');
            }
            var uploader = new ss.SimpleUpload({
                button: btn,
                url: window.ctx + '/aldUploadNew/uploadImg',
                name: 'file',
                multipart: true,
                hoverClass: 'hover',
                focusClass: 'focus',
                responseType: 'text',
                allowedExtensions:["jpg", "jpeg", "png", "gif"],
                onChange: function (filename, extension, uploadBtn) {

                    $(img).addClass('uploadImg'+key);
                    $(img).addClass('reUpload'+key);
//                        console.log(uploader._input);
//                        console.log(uploader._input.files);
                    if (uploader._input.files && uploader._input.files[0]) {//if supports base64
                        var oFReader = new FileReader();
                        oFReader.readAsDataURL(uploader._input.files[0]);
                        oFReader.onload = function (oFREvent) {
                            $(img).attr('src',oFREvent.target.result );
                        };
                        $(img).addClass('base64');
                    } else {
                        $(img).attr('src',window.ctx + '/resources/js/imageUpload/111.png');
//                            console.log('here1');
                    }
                },
                startXHR: function () {
                    progressOuter.show(); // make progress bar visible
                    this.setProgressBar(progressBar);
                    // this.setPctBox(progressBar);
                    showModal.removeClass('active');
                    addBtn.addClass('text-center');
                    addBtn.text('点击图片重新上传').css('color','#ffffff');
                },
                onSubmit: function () {
                    btn.hide();
                },
                onComplete: function (filename, response) {
                    this.clearQueue();
                    progressOuter.hide(); // hide progress bar when upload is  completed
                    var responseJson = JSON.parse(response);
                    if (!response) {
                        //msgBox.innerHTML = 'Unable to upload file';
                        return;
                    }
                    if (responseJson.isSuccess == true) {
                        this.addButton($('.reUpload'+key));
                        showModal.addClass('active');
                        $par.find('.clickBtn').removeClass('hide');
                        $par.find('.inputVal').val(responseJson.resultData.urlPath);
//                            console.log($par.find('.inputVal'));
                        console.log($par.find('.inputVal').val());
                        btn.hover(
                            function() {
                                showModal.addClass('active');
                            }, function() {
                                showModal.removeClass('active');
                            }
                        );
                        if(!$('.uploadImg'+key).hasClass('base64')){
                            $('.uploadImg'+key).attr("src",responseJson.resultData.urlPath);
                        }
                        // alert(typeof (fun));
                        if(typeof (fun)=='function'){
                            fun($this,response);
                        }

                    } else {

                    }
                },
                onError: function (filename, errorType, status, statusText, response) {
//                        console.log(filename);
//                        console.log(errorType);
//                        console.log(status);
//                        console.log(statusText);
//                        console.log(response);
                    //msgBox.innerHTML = errorType + ' , ' + filename+' upload failed.';
                    // progressOuter.style.display = 'none';
                    $('.uploadImg'+key).attr("src",window.ctx+"/resources/js/imageUpload/111.png");
//                        console.log('here3');
                    this.enable();
                }
            });
        });
    }
}
