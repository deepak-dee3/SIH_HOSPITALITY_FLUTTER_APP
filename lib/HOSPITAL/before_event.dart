import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/FIREBASE/firebase_before.dart';
import 'package:sih2024/HOSPITAL/hos_main_page.dart';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class before_event extends StatefulWidget{
  @override
  State<before_event> createState() => before_event_pageState();
}

class before_event_pageState extends State<before_event> {


   String before_hos_name =' ',before_program_name =' ',before_place=' ',before_date=' ',before_availability=' ',before_sd=' ',before_dis=' ',before_state=' ';
 

  TextEditingController before_hos_name_controller = TextEditingController();
  TextEditingController before_program_name_contoller = TextEditingController();
  TextEditingController before_place_controller = TextEditingController();
  TextEditingController before_date_contoller = TextEditingController();
  TextEditingController before_availability_controller = TextEditingController();
  TextEditingController before_sub_dis_controller = TextEditingController();
  TextEditingController before_dis_contoller = TextEditingController();
  TextEditingController before_state_or_union_controller = TextEditingController();

  
  

  final before_formkey = GlobalKey<FormState>();

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

   Future<void> pickImageAndUpload_cam() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File imageFile = File(image.path);

      // Optionally, compress the image
      int fileSize = await imageFile.length();
      if (fileSize <= 5000 * 1024) {
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
    
      // String hospitalName = after_hos_name_controller.text.trim();
       //String date = after_date_controller.text.trim();
       String hospitalName = before_hos_name_controller.text.trim().replaceAll('/', '_');
String date = before_date_contoller.text.trim().replaceAll('/', '_');
String programName = before_program_name_contoller.text.trim().replaceAll('/', '_');
 

   
      // Specify the file name and format as .jpeg
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('HOSPITAL_BEFORE_PREMIT_PROOF/${hospitalName}_${date}_${programName}.jpeg');

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
   
     var screenWidth = MediaQuery.of(context).size.width; 
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body:Padding(padding: EdgeInsets.all(8),child:Container(child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Form(key:before_formkey,
          child:Column(

        children: [

           Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.0, 
   
            child:Lottie.asset('assets/ANIMATION/Animation - 1723986486515.json'),
            ),),
          ),

          SizedBox(height: screenHeight*0.02,),

          Align(alignment: Alignment.centerLeft,child:Text("Hospital's Name :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_hos_name_controller,

            decoration: InputDecoration(
              hintText: 'eg : abc_hospital',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("Program Name :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_program_name_contoller,

            decoration: InputDecoration(
              hintText: 'eg : Eye donation',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("Program Place :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_place_controller,

            decoration: InputDecoration(
              hintText: 'eg : Agra',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("Program Date :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_date_contoller,

            decoration: InputDecoration(
              hintText: 'eg : 01/01/2024',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("Availability :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_availability_controller,

            decoration: InputDecoration(
              hintText: 'eg : 500',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("Sub District :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_sub_dis_controller,

            decoration: InputDecoration(
              hintText: 'eg : Perundurai',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("District :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_dis_contoller,

            decoration: InputDecoration(
              hintText: 'eg : Erode',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),

          Align(alignment: Alignment.centerLeft,child:Text("State / Union Territory :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_state_or_union_controller,

            decoration: InputDecoration(
              hintText: 'eg : TamilNadu / Puducherry',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),

          SizedBox(height: screenHeight*0.04,),
                    Align(alignment: Alignment.centerLeft,child:Text("Upload Permit Letter Image :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

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
              onTap: pickImageAndUpload_cam,
              child: Column(
                children: [
                  Container(
                    width: screenWidth*0.4,
                    height: screenHeight*0.12,
                    decoration: BoxDecoration(
                     // color: Color.fromARGB(255, 222, 5, 5),
                     color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                        //  color: const Color.fromARGB(255, 181, 28, 17).withOpacity(0.6),
                          color: Colors.blue.withOpacity(0.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(child: Icon(Icons.camera)),
                  ),
                  SizedBox(height: screenHeight*0.01), // Add some spacing between icon and text
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
              onTap: pickImageAndUpload
               
              ,
              child: Column(
                children: [
                  Container(
                    width: screenWidth*0.4,
                    height:screenHeight*0.12,
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
                  SizedBox(height: screenHeight*0.01), // Add some spacing between icon and text
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






           SizedBox(height: screenHeight*0.04,),

            GestureDetector(
              onTap:(){


                  if(before_formkey.currentState!.validate())
          {
            
            setState(() {
             
             before_hos_name = before_hos_name_controller.text.trim();
             before_program_name = before_program_name_contoller.text.trim();
             before_place = before_place_controller.text.trim();
             before_date = before_date_contoller.text.trim();
             before_availability = before_availability_controller.text.trim();
             before_sd = before_sub_dis_controller.text.trim();
             before_dis = before_dis_contoller.text.trim();
             before_state = before_state_or_union_controller.text.trim();

            });
          }

          create(
            before_hos_name ,
             before_program_name ,
             before_place,
             before_date ,
             before_availability ,
             before_sd,
             before_dis,
             before_state,

          );

         

           Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => hos_opening_page()),
        (route) => false,
      );

         


              
              },child:Container(alignment: Alignment.center,
      height:  screenHeight * 0.08,
      width:double.infinity,
      //width: screenWidth * 0.,
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
      
        Text('Submit',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17,))
      
      )),

      SizedBox(height: screenHeight*0.04,)








          




        ],
      )))
    )));
  }
}