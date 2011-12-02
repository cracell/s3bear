//Page Handling.js
 $(function() {
   if (url_param('mode') == 'multiple') {
     $('#upload_field').attr('multiple', 'true')  
   }

   $('a').append("<img src='" + s3bear_upload_image_path() + "' />");

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
       var ext = file.name.split(".").pop();
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
       var file = $('#upload_field')[0].files[number];
       return ((file.name || file.fileName));
     },
     sendBoundary: false,
     setName: function(text) {
         $("#progress_report_name").text(text);
     },
     setStatus: function(text) {
       $("#progress_report_status").text(text);
     },
     onProgress: function(event, progress, name, number, total) {
       pm({
         target: window.parent,
         type: "s3bear-progress", 
         data: {progress: Math.ceil(progress*100)+"%", klass: klass(number)}
       });
     },
     onStartOne: function(event, name, number, total) {
       pm({
         target: window.parent,
         type:"s3bear-start", 
         data: {filename: name, klass: klass(number)}
       });
       return true;
     },
     onFinishOne: function(event, response, name, number, total) {
       pm({
         target: window.parent,
         type:"s3bear-complete", 
         data: {filename: name, klass: klass(number)}
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

 function url_param(name) {
   name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
   var regexS = "[\\?&]"+name+"=([^&#]*)";
   var regex = new RegExp( regexS );
   var results = regex.exec( window.location.href );
   if( results == null )
     return "";
   else
     return results[1];
 }

 function s3bear_upload_image_path() {
   if (url_param('upload_image_url')) {
     return url_param('upload_image_url');
   } else {
     return '/assets/upload_button.png';
   }
 }
 
function klass(number) {
   return ('s3bear-' + number);
}