var imgCloud = function(option){
  var $progressBox = $(".imgCloud_progress_box");
  // 初始化Web Uploader
  var uploader = WebUploader.create({
    pick: {
      id: option.$btn,
      multiple: true
    },
    swf: "./Uploader.swf",
    accept: {
      title: 'Images',
      extensions: 'gif,jpg,jpeg,bmp,png',
      mimeTypes: 'image/*'
    },
    compress: false,
    fileSingleSizeLimit: 1024 * 1024,
    auto: true,
    threads:99,
    server: option.server
  });
  // 当有文件添加进来时执行，负责view的创建
  function addFile(file) {
    var showError = function (code) {
      switch (code) {
        case 'exceed_size':
          text = '文件大小超出';
          break;

        case 'interrupt':
          text = '上传暂停';
          break;

        default:
          text = '上传失败，请重试';
          break;
      }
    };
    if (file.getStatus() === 'invalid') {
      showError(file.statusText);
    } else {

    }
  }
  //当文件被加入队列之前触发，此事件的handler返回值为false，则此文件不会被添加进入队列
  uploader.on('beforeFileQueued', function (file) {
    //重置下队列，这样可以上传重复的图片
  });
  // 当有文件添加进来的时候
  uploader.on('fileQueued', function (file) {
    console.log('fileQueued');
    console.log(file);
    var fileName = file.name;
    var fileSize = parseInt(file.size/1024);
    var fileId = file.id;
    $progressBox.show();
    var $progressTpl = '<div class="imgCloud_progress" id="'+fileId+'">'+
                        '<p class="imgCloud_progress_left">'+
                        '<span class="imgCloud_progress_name ellipsis text-right">'+fileName+'</span>'+
                        '<span class="imgCloud_progress_size">('+fileSize+'k)</span></p>'+
                        '<div class="imgCloud_progress_bar">'+
                        '<div class="progress">'+
                        '<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">0%</div></div></div>'+
                        '<span class="imgCloud_progress_right">取消</span></div>'
    $progressBox.append($progressTpl);


  });
  //当某个文件发送前触发
  uploader.on('uploadStart', function (file) {
    console.log("uploadStart");
    console.log(file.name);
    uploader.option('formData', {
      fileName : file.name
    });
  });
  // 文件上传过程中创建进度条实时显示
  uploader.on('uploadProgress', function (file, percentage) {
    var percent = Math.round(percentage * 100);
    console.log('uploadProgress');
    console.log(file.name);
    console.log(percent);
    //updateTotalProgress();
    var $progressBar = $("#"+file.id).find(".progress-bar");
    $progressBar.css("width",percent+"%");
    $("#"+file.id).find(".progress-bar").text(percent+'%')
    $btnCancel = $("#"+file.id).find(".imgCloud_progress_right");
    $btnCancel.on('cilck', function(){
      uploader.cancelFile( file );
    });
  });
  // 文件上传成功
  uploader.on('uploadSuccess', function (file, response) {
    console.log('uploadSuccess');
    option.uploadSuccess(response);
    var fileList = uploader.getStats();
    console.log(fileList);
    if(fileList.progressNum == 0){
      $progressBox.hide();
      option.uploadSuccess(file,response);
    }
    $("#"+file.id).hide();
  });
  // 文件上传失败，显示上传出错
  uploader.on('uploadError', function (file, reason) {
    console.log(reason);
    option.uploadError(reason);
  });
  // 完成上传完了，成功或者失败
  uploader.on('uploadComplete', function (file) {
    //$progress.hide();
  });
};