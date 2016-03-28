function escapeTags(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}
window.onload = function() {
  var btn = document.getElementById('uploadBtn'),
    progressBar = document.getElementById('progressBar'),
    progressOuter = document.getElementById('progressOuter'),
    msgBox = document.getElementById('msgBox');
  var uploader = new ss.SimpleUpload({
    button: btn,
    url: 'file_upload.php',
    name: 'uploadfile',
    multipart: true,
    hoverClass: 'hover',
    focusClass: 'focus',
    responseType: 'json',
    startXHR: function() {
      progressOuter.style.display = 'block'; // make progress bar visible
      this.setProgressBar(progressBar);
      this.setPctBox(progressBar);
    },
    onSubmit: function() {
      msgBox.innerHTML = ''; // empty the message box
      btn.innerHTML = 'Uploading...'; // change button text to "Uploading..."
    },
    onComplete: function(filename, response) {
      btn.innerHTML = 'Choose Another File';
      progressOuter.style.display = 'none'; // hide progress bar when upload is completed
      if (!response) {
        msgBox.innerHTML = 'Unable to upload file';
        return;
      }
      if (response.success === true) {
        msgBox.innerHTML = '<strong>' + escapeTags(filename) + '</strong>' + ' successfully uploaded.';
      } else {
        if (response.msg) {
          msgBox.innerHTML = escapeTags(response.msg);
        } else {
          msgBox.innerHTML = 'An error occurred and the upload failed.';
        }
      }
    },
    onError: function(filename,errorType,status,statusText,response) {
      console.log(filename);
      console.log(errorType);
      console.log(status);
      console.log(statusText);
      console.log(response);
      msgBox.innerHTML = errorType + ' , ' + filename+' upload failed.';
      // progressOuter.style.display = 'none';
      btn.innerHTML = 'Error,retry';
      this.enable();
    }
  });
};
