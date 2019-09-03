<%@ Page Title="Upload Images Using DropzoneJs in Asp.net C#." Language="C#"  AutoEventWireup="true" CodeFile="ImageUploadWithDropzoneJS.aspx.cs" Inherits="ImageUploadWithDropzoneJS" %>

<head>
    <title="Upload Images Using DropzoneJs in Asp.net C#."></title>
    <script src="latestJs_1.11/jquery.min.js"></script>
    <script src="DropzoneJs_scripts/dropzone.js"></script>
    <script src="https://unpkg.com/cropperjs"></script>
    <link rel="stylesheet" href="cropper/cropper.min.css">
    <script type="text/javascript" src="Webcam_Plugin/webcam.min.js"></script>
    <link href="DropzoneJs_scripts/dropzone.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"
        integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
       #camera_wrapper {
            padding:20px; border:1px solid; background:#ccc;
            text-align: center;
            margin:0 auto;
            display:inline-block;
       }

       #dZUpload {
            border: 2px solid #0087F7;
            border-radius: 5px;
            background: white;
            position: relative;
            min-height: 200px;
            max-height: 490px;
            overflow-y: hidden;
            width: inherit;
            padding: 20px;

       }
       
       
       @media screen and (orientation:portrait) {
           #container {
            height: 50px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 50px;
            width:400px;
        }
       }
       @media screen and (orientation:landscape) {
        #container {
            top: 200px;
            height: 50px;
            width: 40em;
            margin-left: auto;
            margin-right: auto;
            margin-top: 50px;
        }
       }

      
    </style>
</head>
<body>
    <div id="container" >
    <div id="cameraDiv" style="display:none; text-align:center ">
    <div id="camera_wrapper" style="text-align:center ">
            <div id="my_camera"></div> 
        <br />
			<div id="pre_take_buttons">
				<!-- This button is shown before the user takes a snapshot -->
				<input type=button value="Take Snapshot" id="take_snap" onClick="preview_snapshot()" class="btn btn-success">
                <input type="button" value="Cancel" id="cancel" onclick="closeDiv()" class="btn btn-alert">
			</div>
			<div id="post_take_buttons" style="display:none">
				<!-- These buttons are shown after a snapshot is taken -->
				<input type=button value="&lt; Take Another" id="take_another" onClick="cancel_preview()" class="btn btn-dark">
				<input type=button value="Save Photo &gt;" id="save" onClick="save_photo()" style="font-weight:bold;" class="btn btn-info">
                <input type="file" hidden />
			</div>
        </div>
     </div>
    <div id="camera_buttons" style="float:left;">
        <input type=button value="Camera" id="Cam" onclick="showDiv()" class="btn btn-primary" style=" margin-right:5px; margin-bottom: 5px">
     </div>
     <div id="normal_buttons" style="float:left; margin-bottom: 5px">
         <input type=button value="Submit" id="submit" class="btn btn-success">
     </div>
        <br />
        <br />
        <div id="myDropzone" class="dropzone" style:"vertical-align: middle;">
        <div class="dz-default dz-message" style=" font-family: sans-serif;">
            Drop image here. 
        </div>
        </div>
   </div>

   

    <script type="text/javascript">
        //Dropzone.autoDiscover = false;
        //var myDropzone = new Dropzone(
        //    "#myDropzone",
        //    {
        //        url: 'hn_SimpeFileUploader.ashx',
        //        capture: "file",
        //        addRemoveLinks: true,
        //        autoProcessQueue: false,
        //        parallelUploads: 20,
        //        transformFile: function (file, done) {


        //        // Create the image editor overlay
        //        var editor = document.createElement('div');
        //        editor.style.position = 'fixed';
        //        editor.style.left = 0;
        //        editor.style.right = 0;
        //        editor.style.top = 0;
        //        editor.style.bottom = 0;
        //        editor.style.zIndex = 9999;
        //        editor.style.backgroundColor = '#000';

        //        // Create the confirm button
        //        var confirm = document.createElement('button');
        //        confirm.style.position = 'absolute';
        //        confirm.style.left = '10px';
        //        confirm.style.top = '10px';
        //        confirm.style.zIndex = 9999;
        //        confirm.textContent = 'Confirm';
        //        confirm.addEventListener('click', function () {

        //            // Get the canvas with image data from Cropper.js
        //            var canvas = cropper.getCroppedCanvas({
        //                width: 256,
        //                height: 256
        //            });

        //            // Turn the canvas into a Blob (file object without a name)
        //            canvas.toBlob(function (blob) {

        //                // Update the image thumbnail with the new image data
        //                myDropZone.createThumbnail(
        //                    blob,
        //                    myDropZone.options.thumbnailWidth,
        //                    myDropZone.options.thumbnailHeight,
        //                    myDropZone.options.thumbnailMethod,
        //                    false,
        //                    function (dataURL) {

        //                        // Update the Dropzone file thumbnail
        //                        myDropZone.emit('thumbnail', file, dataURL);

        //                        // Return modified file to dropzone
        //                        done(blob);
        //                    }
        //                );

        //            });

        //            // Remove the editor from view
        //            editor.parentNode.removeChild(editor);

        //        });
        //        editor.appendChild(confirm);

        //        // Load the image
        //        var image = new Image();
        //        image.src = URL.createObjectURL(file);
        //        editor.appendChild(image);

        //        // Append the editor to the page
        //        document.body.appendChild(editor);

        //        // Create Cropper.js and pass image
        //        var cropper = new Cropper(image, {
        //            aspectRatio: 1
        //        });

        //    }
        //});
        var c = 0;
        Dropzone.autoDiscover = false;
        var myDropzone = new Dropzone(
            "#myDropzone",
            {
                url: "hn_SimpeFileUploader.ashx",
                capture: "file",
                addRemoveLinks: true,
                autoProcessQueue: false,
                parallelUploads: 20,
                success: function (file, response) {
                    var imgName = response;
                    file.previewElement.classList.add("dz-success");
                    console.log("Successfully uploaded :" + imgName);
                   
                      
                },
                error: function (file, response) {
                    file.previewElement.classList.add("dz-error");
                }
            });


        $('#submit').click(function () {
            myDropzone.processQueue(); 
        });

        myDropzone.on("addedfile", function (file) {
            var $button = $('<a href="#" class="js-open-cropper-modal" data-file-name="' + file.name + '">Crop & Upload</a>');
            $(file.previewElement).append($button);
        });
        

        $('#myDropzone').on('click', '.js-open-cropper-modal', function (e) {
            e.preventDefault();
            var fileName = $(this).data('file-name-data');
            console.log(fileName);
            var modalTemplate =
                '<div class="modal fade" tabindex="-1" role="dialog">' +
                '<div class="modal-dialog modal-lg" role="document">' +
                '<div class="modal-content">' +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                '<h4 class="modal-title">Crop</h4>' +
                '</div>' +
                '<div class="modal-body">' +
                '<div class="image-container">' +
                '<img id="img-' + ++c + '" src="' + fileName + '">' +
                '</div>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<button type="button" class="btn btn-warning rotate-left"><span class="fa fa-rotate-left"></span></button>' +
                '<button type="button" class="btn btn-warning rotate-right"><span class="fa fa-rotate-right"></span></button>' +
                '<button type="button" class="btn btn-warning scale-x" data-value="-1"><span class="fa fa-arrows-h"></span></button>' +
                '<button type="button" class="btn btn-warning scale-y" data-value="-1"><span class="fa fa-arrows-v"></span></button>' +
                '<button type="button" class="btn btn-warning reset"><span class="fa fa-refresh"></span></button>' +
                '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>' +
                '<button type="button" class="btn btn-primary crop-upload">Crop & upload</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';

            var $cropperModal = $(modalTemplate);

            $cropperModal.modal('show').on("shown.bs.modal", function () {
                var cropper = new Cropper(document.getElementById('img-' + c), {
                    autoCropArea: 1,
                    movable: false,
                    cropBoxResizable: true,
                    rotatable: true
                });
                var $this = $(this);
                $this
                    .on('click', '.crop-upload', function () {
                        // get cropped image data
                        var blob = cropper.getCroppedCanvas().toDataURL();
                        // transform it to Blob object
                        var croppedFile = dataURItoBlobCropper(blob);
                        croppedFile.name = fileName;

                        var files = myDropzone.getAcceptedFiles();
                        for (var i = 0; i < files.length; i++) {
                            var file = files[i];
                            if (file.name === fileName) {
                                myDropzone.removeFile(file);
                            }
                        }
                        myDropzone.addFile(croppedFile);
                        $this.modal('hide');
                    })
                    .on('click', '.rotate-right', function () {
                        cropper.rotate(90);
                    })
                    .on('click', '.rotate-left', function () {
                        cropper.rotate(-90);
                    })
                    .on('click', '.reset', function () {
                        cropper.reset();
                    })
                    .on('click', '.scale-x', function () {
                        var $this = $(this);
                        cropper.scaleX($this.data('value'));
                        $this.data('value', -$this.data('value'));
                    })
                    .on('click', '.scale-y', function () {
                        var $this = $(this);
                        cropper.scaleY($this.data('value'));
                        $this.data('value', -$this.data('value'));
                    });
            });
        });
        
        var dataURItoBlobCropper = function (dataURI) {
            var byteString = atob(dataURI.split(',')[1]);
            var ab = new ArrayBuffer(byteString.length);
            var ia = new Uint8Array(ab);
            for (var i = 0; i < byteString.length; i++) {
                ia[i] = byteString.charCodeAt(i);
            }
            return new Blob([ab], { type: 'image/jpeg' });
        };
        
        if (screen.height <= screen.width) {
            // Landscape
            Webcam.set({
                width: 320,
                height: 240,
                dest_width: 1280,
                dest_height: 720,
                // format and quality
                image_format: 'jpeg',
                jpeg_quality: 100,
                flash_falback: true,
            });

        } else {
            // Portrait
            Webcam.set({
                width: 240,
                height: 320,
                dest_width: 720,
                dest_height: 1280,
                // format and quality
                image_format: 'jpeg',
                jpeg_quality: 100,
                flash_falback: true,
            });
        }
        Webcam.attach('#my_camera');

        function preview_snapshot() {
                // freeze camera so user can preview pic
                Webcam.freeze();

            // swap button sets
            document.getElementById('pre_take_buttons').style.display = 'none';
            document.getElementById('post_take_buttons').style.display = '';
        }

        function cancel_preview() {
                // cancel preview freeze and return to live camera feed
                Webcam.unfreeze();

            // swap buttons back
            document.getElementById('pre_take_buttons').style.display = '';
            document.getElementById('post_take_buttons').style.display = 'none';
        }

        function save_photo() {
                // actually snap photo (from preview freeze) and display it
                Webcam.snap(function (data_uri) {
                   
                    // swap buttons back
                    document.getElementById('pre_take_buttons').style.display = '';
                    document.getElementById('post_take_buttons').style.display = 'none';

                    save(data_uri);
                   
                });
            
        }
        function dataURItoBlob(dataURI) {
                'use strict'
            var byteString,
                mimestring

            if (dataURI.split(',')[0].indexOf('base64') !== -1) {
                byteString = atob(dataURI.split(',')[1])
            } else {
                byteString = decodeURI(dataURI.split(',')[1])
            }
            mimestring = dataURI.split(',')[0].split(':')[1].split(';')[0]
            
            var content = new Array();
            for (var i = 0; i < byteString.length; i++) {
                content[i] = byteString.charCodeAt(i)
            }

            return new Blob([new Uint8Array(content)], {type: mimestring });
        }
    </script>

    <script type="text/javascript">
        function save(dataURI) {
            var blob = dataURItoBlob(dataURI);
            blob = blob.slice(0, blob.size, "image/jpeg")
            //var image = new Image();
            //image.src = URL.createObjectURL(blob);
            blob.name = uuidv4() + '.jpeg';
            myDropzone.addFile(blob);
            //myDropzone.addFile(image, "test.jpg");
        }

        function uuidv4() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }

        function showDiv() {
            document.getElementById('cameraDiv').style.display = 'block';
         
            // swap buttons back
            document.getElementById('camera_buttons').style.display = 'none';

        }
        function closeDiv() {
            document.getElementById('cameraDiv').style.display = 'none';
            document.getElementById('camera_buttons').style.display = '';
        } 
        </script>
    
    <script type="text/javascript">
       
    </script>

     
</body>

