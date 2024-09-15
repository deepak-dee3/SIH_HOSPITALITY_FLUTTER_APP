import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/HOSPITAL/after_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sih2024/FIREBASE/firebase_imp.dart';
import 'package:sih2024/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';



class sign_up extends StatefulWidget{
  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {

   String email = ' ', password = ' ', hos_name = ' ',phone = ' ',hos_type=' ',hos_loc=' ',head_hos= ' ',landmark= ' ',add_phone=' ';
  TextEditingController emailcontroller =  TextEditingController();
  TextEditingController passcontroller =  TextEditingController();
  TextEditingController hos_name_controller =  TextEditingController();
  TextEditingController phonecontroller =  TextEditingController();
  TextEditingController hos_type_controller =  TextEditingController();
  TextEditingController hos_loc_controller =  TextEditingController();
  TextEditingController head_hos_controller =  TextEditingController();
  TextEditingController landmark_controller =  TextEditingController();
  TextEditingController add_phone_controller =  TextEditingController();



  final _formkey= GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  registration() async {
    
    if(password!=null)
    {
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        await storage.write(key: 'password', value: password); 
        //String? storedPassword = await storage.read(key: 'password');
       // await storage.delete(key: 'password');
             create(hos_name,email,head_hos,hos_type,hos_loc,landmark,phone,add_phone);
             
             
             

       
       Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => LoginPage()),
  (Route<dynamic> route) => false, 
);

emailcontroller.clear();
hos_name_controller.clear();
passcontroller.clear();
       

      }on FirebaseAuthException catch (e)
      {
        if(e.code == 'weak passord'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password provided is too weak',style:TextStyle(fontSize: 20))));
        }/*else if(e.code == 'email-already-in-use')
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email in use',style:TextStyle(fontSize: 20))));
        }*/
        return null;
        }} }

      /*  final ImagePicker _imagePicker = ImagePicker();
          List<File> _pickedImages = [];
  String? imageUrl;

 /* Future<void> pickImageAndUpload() async {
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
  }*/
  Future<void> pickImageAndAddToList(ImageSource source) async {
  XFile? image = await _imagePicker.pickImage(source: source);
  if (image != null) {
    File imageFile = File(image.path);
    int fileSize = await imageFile.length();
    if (fileSize <= 200 * 1024) {
      setState(() {
        _pickedImages.add(imageFile);
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Please pick an image below 200 KB in size.',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}


 /*  Future<void> pickImageAndUpload_cam() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

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
  }*/
  Future<void> pickImageAndAddToList1(ImageSource source) async {
  XFile? image = await _imagePicker.pickImage(source: source);
  if (image != null) {
    File imageFile = File(image.path);
    int fileSize = await imageFile.length();
    if (fileSize <= 5000 * 1024) {
      setState(() {
        _pickedImages.add(imageFile);
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Please pick an image below 200 KB in size.',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}


  /*Future<void> pickImagesAndUpload() async {
  List<XFile>? images = await _imagePicker.pickMultiImage();

  if (images != null && images.isNotEmpty) {
    for (XFile image in images) {
      File imageFile = File(image.path);

      // Optionally, compress the image
      int fileSize = await imageFile.length();
      if (fileSize <= 200 * 1024) {
        // Upload the image to Firebase
        await uploadToFirebase(imageFile);
      } else {
        Fluttertoast.showToast(
          msg: 'Please pick an image below 200 KB in size.',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }
}*/



 /* Future<void> uploadToFirebase(File imageFile) async {
    try {
    
      // String hospitalName = after_hos_name_controller.text.trim();
       //String date = after_date_controller.text.trim();
       String hospitalName = hos_name_controller.text.trim().replaceAll('/', '_');

 

   
      // Specify the file name and format as .jpeg
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('HOSPITAL_IMAGES/${hospitalName}.jpeg');

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
  }*/
  Future<void> uploadImagesToFirebase() async {
  try {
    
    for (File imageFile in _pickedImages) {
    //  String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
     String hospitalName = hos_name_controller.text.trim().replaceAll('/', '_');
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('HOSPITAL_IMAGES/$hospitalName');
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await storageReference.putFile(imageFile, metadata);
      String imageUrl = await storageReference.getDownloadURL();
      print('Image uploaded: $imageUrl');
    }
    setState(() {
      Fluttertoast.showToast(msg: "All images uploaded successfully!");
    });
  } catch (e) {
    Fluttertoast.showToast(msg: "Error uploading images: $e");
  }
}
*/

//////////////////////////////////////////
 String? imageurl;
  final ImagePicker _imagepic = ImagePicker();

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

     

      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Uploading your image',
      );

      File compressedFile = await compressImage(_pickedImage!);

      final now = DateTime.now();
      final contentWithDate = "${hos_name_controller.text}";

      Reference image_ref = FirebaseStorage.instance.ref().child('HOSPITAL_IMAGES/$contentWithDate.jpg');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      await image_ref.putFile(compressedFile, metadata).whenComplete(() async {
        imageurl = await image_ref.getDownloadURL();
        hos_name_controller.clear();

        registration();
        
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
    var screenHeight = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.height;
   return Scaffold(
    backgroundColor: Colors.white,

    body:Padding(padding: EdgeInsets.all(16),child:Center(child:Container(
      height: screenHeight*2,width: screenWidth*9,
      color: Colors.white,
      child: SingleChildScrollView(scrollDirection: Axis.vertical
      ,child:Form(key: _formkey,
        child:Column(
      children: [
        SizedBox(height: screenHeight*0.05,),

        Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.0, 

            child:Lottie.asset('assets/ANIMATION/Animation - 1724088370891.json'),
            ),),
          ),

          SizedBox(height: screenHeight*0.05,),

           Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hospital Address",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                    // controller: login_emailcontroller,
                    controller: emailcontroller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your email *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.black,
                          hintText: "Email",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                 color: Colors.blue.withOpacity(0.2),
                // color: Color.fromARGB(255, 15, 190, 21),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                   //  controller: login_emailcontroller,
                   controller: passcontroller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your user password *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Colors.black,
                          hintText: "Set your password",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
               SizedBox(height: screenHeight*0.08,),

          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hospital Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                   controller: hos_name_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your hospital name * ";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.text_format),
                          prefixIconColor: Colors.black,
                          hintText: "Name",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hospital Type",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                    controller: hos_type_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your hospital type *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.merge_type),
                          prefixIconColor: Colors.black,
                          hintText: "General , Multispeciality,Urgent care",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
               SizedBox(height: screenHeight*0.08,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                 color: Colors.blue.withOpacity(0.2),
                // color: Color.fromARGB(255, 15, 190, 21),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Head of Hospital",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                  controller: head_hos_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter name of the head *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.black,
                          hintText: "Name",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),

              SizedBox(height: screenHeight*0.08,),

               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hospital Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                    controller: hos_loc_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter hospital location *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: Colors.black,
                          hintText: "Address",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                 color: Colors.blue.withOpacity(0.2),
                // color: Color.fromARGB(255, 15, 190, 21),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Landmark",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                   controller: landmark_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter hospital's landmark *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.label),
                          prefixIconColor: Colors.black,
                          hintText: "Nearby Landmark",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
               SizedBox(height: screenHeight*0.08,),

          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                    controller: phonecontroller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter hospital number * ";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          prefixIconColor: Colors.black,
                          hintText: "Phone Number",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                 color: Colors.blue.withOpacity(0.2),
                // color: Color.fromARGB(255, 15, 190, 21),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                  controller:add_phone_controller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter hospital additional number *";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          prefixIconColor: Colors.black,
                          hintText: "Additional Number",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),

                Align(alignment: Alignment.center,child:Text("Upload Hospital License :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),


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
              onTap: (){
               pickimage_cam();
              },
              child: Column(
                children: [
                  Container(
                    width: screenWidth*0.4,
                    height: screenHeight*0.26,
                    decoration: BoxDecoration(
                     // color: Color.fromARGB(255, 222, 5, 5),
                     color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                         // color: const Color.fromARGB(255, 181, 28, 17).withOpacity(0.6),
                        // color: Colors.green,
                          color: Colors.blue.withOpacity(0.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(child: Icon(Icons.camera)),
                  ),
                  SizedBox(height: screenHeight*0.02), // Add some spacing between icon and text
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
              onTap:(){ pickimage();
              }
               
              ,
              child: Column(
                children: [
                  Container(
                    width: screenWidth*0.4,
                    height:screenHeight*0.26,
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
                  SizedBox(height: screenHeight*0.02), // Add some spacing between icon and text
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


             /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             /* GestureDetector(
                onTap:pickImageAndUpload,
                child: Container(alignment:Alignment.center ,
            height: screenHeight*0.1,
            width: screenWidth*0.3,
           // color: Colors.red,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
           child: Icon(Icons.upload_rounded),
            )),*/
            GestureDetector(onTap:pickImageAndUpload,
              child:
             Container(alignment:Alignment.center ,
            height: screenHeight*0.2,
            width: screenWidth*0.3,
            child:Row( 
              children: [
                SizedBox(width: screenWidth*0.04,),
                
              
              Icon(Icons.upload_rounded),

              Text('Hospital Image',style: TextStyle(fontWeight: FontWeight.bold),)
              ]),
           // color: Colors.red,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.blue),
            ))
          ]),*/
          


              SizedBox(height: screenHeight*0.04,),

               GestureDetector(
              onTap:(){

                 if(_formkey.currentState!.validate())
          {
            setState(() {
              email = emailcontroller.text.trim();
              hos_name = hos_name_controller.text.trim();
              hos_loc = hos_loc_controller.text.trim();
              hos_type = hos_type_controller.text.trim();
              head_hos=head_hos_controller.text.trim();
              landmark = landmark_controller.text.trim();
              phone = phonecontroller.text.trim();
              add_phone = add_phone_controller.text.trim();
              password = passcontroller.text.trim();

            });
          }
          

          uploadfirebase();
         
              },child:Container(alignment: Alignment.center,
      height:  screenHeight * 0.18,
      width:double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.red,

      decoration: BoxDecoration(
         boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 18, 8, 88).withOpacity(0.6),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                 
                  
                ],
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromARGB(255, 13, 124, 17),
       
      
      ),child:
      
        Text('Sign Up',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17,))
      
      )),
      SizedBox(height: screenHeight*0.08,)

         

         
             








      ],
    ),)))
   )));
  }
}