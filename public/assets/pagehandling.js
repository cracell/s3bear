//Page Handling.js
$(function() {
  $("#upload_field").html5_upload({
    autostart:false,
    method:'PUT',
    STATUSES:{
    'STARTED':'Started',
    'PROGRESS':'Progress',
    'LOADED':'Loaded',
    'FINISHED':'Finished'
    },
    headers:{
    'x-amz-acl':'public-read',
    'Content-Type':function(file){
      var ext = file.fileName.split(".").pop();
      switch(ext){
        case 'htm':
        case 'html':
        case 'htmls':
        return 'text/html';
        case 'css':
        return 'text/css';
        case 'gif':
        return 'image/gif';
        case 'jpeg':
        case 'jpg':
        return 'image/jpeg';
        case 'png':
        return 'image/png';
        case 'pdf':
        return 'application/pdf';
        case 'zip':
        return 'application/zip';
        default:
        return 'application/octet-stream';
      }
      return('application/octet-stream');
    }
    },
    genName: function(file, number, total) {
      return file + "(" + (number+1) + " of " + total + ")";
    },
    url: function(number) {
      return ($('#upload_field')[0].files[number].fileName);
    },
    sendBoundary: false,
    setName: function(text) {
        $("#progress_report_name").text(text);
    },
    setStatus: function(text) {
      $("#progress_report_status").text(text);
    },
    setProgress: function(val) {
      pm({
        target: window.parent,
        type: "s3bear-progress", 
        data: Math.ceil(val*100)+"%"
      });
    },
    onFinishOne: function(event, response, name, number, total) {
      pm({
        target: window.parent,
        type:"s3bear-complete", 
        data: {filename: name}
      });
      //window.parent.postMessage(name, 'http://localhost:3000');
      //$('#image-link').attr('href', ('/' + name));
      
    }
  });

  $('#upload_field').change(function(e){
    $('#upload_field').triggerHandler('html5_upload.start');
  });
  
  $('a').click(function(e) {
    e.preventDefault();
  })
});