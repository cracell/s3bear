$(window).load(function(){
  S3Bear.init();
  
  $('.upload-container .remove').click(function(e) {
    e.preventDefault();
    $('.standard-submit')
      .removeAttr("disabled")
      .attr('src', $('.standard-submit').data('src-path'));
    $('iframe.s3bear-upload').css('visibility', 'visible');
    
    $($('.upload-container').data('url-field')).val('');

    $('#image_successful').hide();
  });
});

var S3Bear = {
  init: function() {
    if (this.fileAPISupport()) {
      this.HTML5.init();
    } else {
      this.flash.init();
    }
  },
  
  fileAPISupport: function() {
    try {
      new FileReader();
      return true;
    } catch(err) {
      return false;
    }
    // This method failed on Chrome. WTF eh?
    // if ("files" in DataTransfer.prototype) {
    //   return true;
    // } else {
    //   return false;
    // }
  },
  
  file_prefix: function() {
    return 'temp/' + new Date().getTime();
  },
  
  s3_path: function() {
    return 'http://' + $('.upload-container').data('s3-bucket') + '.s3.amazonaws.com'
  },

  upload_start: function() {
    $('iframe.s3bear-upload').css('visibility', 'hidden');
    $('#progress_bar').data('upload-started', true);
    $('#progress_bar').show();
    $('.standard-submit').attr("disabled", "disabled");
  },
  
  update_progress: function(percentage) {
    $('#progress_bar .progress_status')
      .css('display', 'block')
      .css('width', percentage);
  },
  
  upload_complete: function(filename) {
    $('#progress_bar').hide();
    $('#image_successful').show();
    $('#image_successful span.filename').html(filename);
    console.log('hi');
    $('.standard-submit')
      .removeAttr("disabled")
      .attr('src', $('.standard-submit').data('src-path'));
    var filepath = S3Bear.s3_path() + '/' + escape(filename);
    $($('.upload-container').data('url-field')).val(filepath);
    if ($('.upload-container').data('submit-form') == true) {
      $('.upload-container').parents('form').submit();
    }
  },
  
  /////////////////////////////
  /// S3 Bear HTML5 Handling //
  ////////////////////////////
  HTML5: {
    
    init: function() {
      this.insert();
      pm.bind("s3bear-progress", function(data) {
        if ($('#image_successful').is(":visible") == false) {
          S3Bear.upload_start();
        }
        S3Bear.update_progress(data);
      });

      pm.bind("s3bear-complete", function(data) {
        S3Bear.upload_complete(data['filename']);
      });
    },
    insert: function() {
      $('.upload-container').prepend("<iframe class='s3bear-upload' src='" + S3Bear.s3_path() + '/upload.html' +'\' /> ')
    }
  },
  ///////////////////////////
  // S3 Bear Flash Fallback Handling
  /////////////////////////
  flash: {
    init: function() {
      createDivToEmbed();
    
    }
    
  }
};