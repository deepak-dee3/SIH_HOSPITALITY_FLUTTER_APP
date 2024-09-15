import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sih2024/main.dart';


class upload_camp_detailss extends StatefulWidget {

  
  @override
  State<upload_camp_detailss> createState() => _upload_camp_detailsState();
}

class _upload_camp_detailsState extends State<upload_camp_detailss> {
  String? imageurl;
  final ImagePicker _imagepic = ImagePicker();
  TextEditingController _campeve_controller = TextEditingController();

  XFile? _pickedImage;

Future<void> pickimage() async {
    XFile? res = await _imagepic.pickImage(source: ImageSource.gallery);

    if (res != null) {
      setState(() {
        _pickedImage = res;
      });
    }
  }

 Future<void>pickimage_cam() async {
    XFile? res = await _imagepic.pickImage(source: ImageSource.camera);

    if (res != null) {
      setState(() {
        _pickedImage = res;
      });
    }
  }

  /*Future<File> compressImage(XFile image) async {
  final compressedImageData = await FlutterImageCompress.compressWithFile(
    image.path,
    minWidth: 900,
    minHeight: 900,
    quality: 95,
  );

  if (compressedImageData == null) {
    throw Exception("Error compressing image");
  }

  final tempDir = await getTemporaryDirectory();
  final tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  final compressedImageFile = File(tempFilePath)..writeAsBytesSync(compressedImageData);

  return compressedImageFile;
}*/
  Future<File> compressImage(XFile image) async {
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    int minWidth = 900;
    int minHeight = 900;
    int quality = 95;

    File compressedFile;

    do {
      final compressedImageData = await FlutterImageCompress.compressWithFile(
        image.path,
        minWidth: minWidth,
        minHeight: minHeight,
        quality: quality,
      );

      if (compressedImageData == null) {
        throw Exception("Error compressing image");
      }

      compressedFile = File(tempFilePath)..writeAsBytesSync(compressedImageData);

      // Reduce quality and dimensions incrementally if the size is still greater than 200 KB
      if (compressedFile.lengthSync() > 200 * 1024) {
        quality -= 10; // Decrease quality by 10%
        minWidth = (minWidth * 0.8).round(); // Decrease width by 20%
        minHeight = (minHeight * 0.8).round(); // Decrease height by 20%
      }
    } while (compressedFile.lengthSync() > 200 * 1024 && quality > 10);

    return compressedFile;
  }

  Future<void> uploadfirebase() async {
    try {
      if (_pickedImage == null) {
        Fluttertoast.showToast(msg: 'Please pick an image');
        return;
      }

      if (_campeve_controller.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Please fill in the content first');
        return;
      }

      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Uploading your image',
      );

      File compressedFile = await compressImage(_pickedImage!);

      final now = DateTime.now();
      final formattedDate = "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";
      final contentWithDate = "${_campeve_controller.text} (Uploaded on: $formattedDate)";

      Reference image_ref = FirebaseStorage.instance.ref().child('CAMP_EVENT_Images/$contentWithDate.jpg');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      await image_ref.putFile(compressedFile, metadata).whenComplete(() async {
        imageurl = await image_ref.getDownloadURL();
        _campeve_controller.clear();
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            padding: EdgeInsets.all(10),
            content: Text('Uploaded successfully', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } catch (e) {
      print('Error uploading image: $e');
      Fluttertoast.showToast(msg: 'Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child:Scaffold(
        
      body: (SingleChildScrollView(scrollDirection: Axis.vertical,
        child:Container(
        child: Column(
          children: [
            SizedBox(height: 50),
             Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 1.5, 
   
            child:Lottie.asset('assets/animation/Animation - 1721312844095.json')),),

            SizedBox(height:20),



            Padding(
              padding: EdgeInsets.all(28),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 15, 18, 117),
                ),
                child: TextFormField(
                  controller: _campeve_controller,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white), 
                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.notes),
                    prefixIconColor: Colors.white,
                    hintText: 'Enter the content',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
  padding: EdgeInsets.all(40),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                pickimage_cam();
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 5, 5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 181, 28, 17).withOpacity(0.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(child: Icon(Icons.camera)),
                  ),
                  SizedBox(height: 8), // Add some spacing between icon and text
                  Text(
                    'Camera',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Expanded(
            child: GestureDetector(
              onTap: () {
                pickimage();
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(child: Icon(Icons.image)),
                  ),
                  SizedBox(height: 8), // Add some spacing between icon and text
                  Text(
                    'Gallery',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),


           /* Padding(
              padding: EdgeInsets.only(left: 80, top: 30),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    
            child: IconButton(
                        
                      
                      onPressed: () {
                        pickimage_cam();
                      },
                      icon: Icon(Icons.camera),
                    ),),
                  
                  SizedBox(width: 30),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {
                        pickimage();
                      },
                      icon: Icon(Icons.image),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Text('Camera', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 75),
                  Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),*/
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                uploadfirebase();
               
              },
              child: Container(
                width: 260,
                height: 60,
                child: Shimmer.fromColors(baseColor: Colors.white,highlightColor: Colors.black,
                  child:Text('Upload',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 18, 13, 93),
                ),
              ),
            ),
          ],
        ),
      ),
    ))));
  }
}

