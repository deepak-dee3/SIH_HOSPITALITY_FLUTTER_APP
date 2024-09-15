/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  List<XFile>? _files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Image Picker'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.red,
                child: file != null
                    ? Image.file(
                        File(file!.path),
                        fit: BoxFit.cover,
                      )
                    : Text('Not Picked'),
              ),
              //Single Image
              TextButton(
                  onPressed: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      file = photo;
                    });
                  },
                  child: Text('Pick  Image')),
              //Multiple Images
              TextButton(
                  onPressed: () async {
                    final List<XFile>? images = await _picker.pickMultiImage();
                    setState(() {
                      _files = images;
                      for (int i = 0; i < _files!.length; i++) {
                        print(_files![i].path);
                      }
                    });
                  },
                  child: Text('Pick Multiple Image'))
            ],
          ),
        ));
  }
}*/
/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  String? downloadURL;
  bool isUploading = false;

  // Function to upload the image to Firebase Storage
  Future<void> uploadImageToFirebaseStorage(File imageFile) async {
    setState(() {
      isUploading = true;
    });

    try {
      // Generate a unique file name for the upload
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload the file to Firebase Storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('HOSPITAL_AFTER_UPLOAD_IMAGES/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Retrieve the download URL of the uploaded file
      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        downloadURL = downloadUrl;
        isUploading = false;
      });

      print("Download URL: $downloadUrl");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload successful!')),
      );
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Image Picker'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.red,
                child: file != null
                    ? Image.file(
                        File(file!.path),
                        fit: BoxFit.cover,
                      )
                    : Text('Not Picked'),
              ),
              SizedBox(height: 20),
              // Show upload progress indicator
              if (isUploading) CircularProgressIndicator(),

              // Show the download URL if available
              if (downloadURL != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Download URL:\n$downloadURL',
                    textAlign: TextAlign.center,
                  ),
                ),

              // Button to pick a single image from the gallery
              TextButton(
                onPressed: () async {
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (photo != null) {
                    setState(() {
                      file = photo;
                    });

                    // Upload image to Firebase Storage
                    await uploadImageToFirebaseStorage(File(file!.path));
                  }
                },
                child: Text('Pick and Upload Image'),
              ),
            ],
          ),
        ));
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PickImageFromGallery extends StatefulWidget {
  @override
  _PickImageFromGalleryState createState() => _PickImageFromGalleryState();
}

class _PickImageFromGalleryState extends State<PickImageFromGallery> {
  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;

  Future<void> pickImageAndUpload() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      // Optionally, compress the image
      int fileSize = await imageFile.length();
      if (fileSize <= 200 * 1024) {
        // Upload the image to Firebase
        uploadToFirebase(imageFile);
      } else {
        Fluttertoast.showToast(
          msg: 'Please pick an image below 200 KB in size.',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  Future<void> uploadToFirebase(File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('Images/${DateTime.now().toString()}');
      await storageReference.putFile(imageFile);
      imageUrl = await storageReference.getDownloadURL();

      setState(() {
        Fluttertoast.showToast(msg: "Image uploaded successfully!");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image")),
      body: Center(
        child: GestureDetector(
          onTap: pickImageAndUpload,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.blue,
            child: imageUrl != null
                ? Image.network(imageUrl!)
                : Center(child: Text('Tap to pick and upload an image', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}


*/
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PickImageFromGallery extends StatefulWidget {
  @override
  _PickImageFromGalleryState createState() => _PickImageFromGalleryState();
}

class _PickImageFromGalleryState extends State<PickImageFromGallery> {
  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;

  Future<void> pickImageAndUpload() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      // Optionally, compress the image
      int fileSize = await imageFile.length();
      if (fileSize <= 200 * 1024) {
        // Upload the image to Firebase
        uploadToFirebase(imageFile);
      } else {
        Fluttertoast.showToast(
          msg: 'Please pick an image below 200 KB in size.',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  Future<void> uploadToFirebase(File imageFile) async {
    try {
      // Specify the file name and format as .jpeg
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('Images/${DateTime.now().toString()}.jpeg');

      // Use settable metadata to explicitly mention the MIME type (optional)
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      
      await storageReference.putFile(imageFile, metadata);
      imageUrl = await storageReference.getDownloadURL();

      setState(() {
        Fluttertoast.showToast(msg: "Image uploaded successfully!");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image")),
      body: Center(
        child: GestureDetector(
          onTap: pickImageAndUpload,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.blue,
            child: imageUrl != null
                ? Image.network(imageUrl!)
                : Center(
                    child: Text(
                      'Tap to pick and upload an image',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
