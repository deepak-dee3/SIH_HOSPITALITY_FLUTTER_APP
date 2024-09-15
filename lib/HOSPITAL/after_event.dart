import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import 'package:sih2024/FIREBASE/firebase_after_event.dart';
import 'package:sih2024/HOSPITAL/hos_main_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:fluttertoast/fluttertoast.dart';


class enter_details_hospoital extends StatefulWidget{
  @override
  State<enter_details_hospoital> createState() => _enter_details_hospoitalState();
}

class _enter_details_hospoitalState extends State<enter_details_hospoital> {
  
  

    



 

  

     


  


   String after_hos_name =' ',after_type=' ',after_program_name =' ',after_place=' ',after_date=' ',
   after_no_parti=' ',after_hours=' ',after_feedback=' ';
    String imageurl = ' ';
 

  TextEditingController after_hos_name_controller = TextEditingController();
  TextEditingController after_program_name_contoller = TextEditingController();
  TextEditingController after_place_controller = TextEditingController();
  TextEditingController after_type_controller = TextEditingController();
  TextEditingController after_date_controller = TextEditingController();
  TextEditingController after_no_parti_controller = TextEditingController();
  TextEditingController after_hours_controller = TextEditingController();
  TextEditingController after_feedback_controller = TextEditingController();
  
  
  

  final after_formkey = GlobalKey<FormState>();

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => hos_opening_page()), // Replace MainPage with your actual main page widget
    );
    return false; // Prevents the default back button action
  }
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



  Future<void> uploadToFirebase(File imageFile) async {
    try {
    
      // String hospitalName = after_hos_name_controller.text.trim();
       //String date = after_date_controller.text.trim();
       String hospitalName = after_hos_name_controller.text.trim().replaceAll('/', '_');
String date = after_date_controller.text.trim().replaceAll('/', '_');
String programName = after_program_name_contoller.text.trim().replaceAll('/', '_');
 

   
      // Specify the file name and format as .jpeg
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('HOSPITAL_AFTER_EVENT_IMAGES/${hospitalName}_${date}_${programName}.jpeg');

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
  /*
  Future<void> uploadToFirebase(File imageFile) async {
  try {
    String hospitalName = after_hos_name_controller.text.trim().replaceAll('/', '_');
    String date = after_date_controller.text.trim().replaceAll('/', '_');
    String programName = after_program_name_contoller.text.trim().replaceAll('/', '_');

    // Create a unique file name for each image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('HOSPITAL_AFTER_EVENT_IMAGES/${hospitalName}_${date}_${programName}_$fileName.jpeg');

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


  

  



  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width; 
    var screenHeight = MediaQuery.of(context).size.height;
    
 
   return WillPopScope( onWillPop: _onWillPop,child:
   Scaffold(
    backgroundColor: Colors.white,

    body:Padding(padding: EdgeInsets.all(16),
    child:Center(child:Container(
      height: screenHeight *2,
      width: screenWidth*9,
      child:(SingleChildScrollView(scrollDirection: Axis.vertical,
      
        child:Form(key: after_formkey,
          child:Column(children: [

        

            Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.0, 
   
            child:Lottie.asset('assets/ANIMATION/Vtl9dAfog1.json'),
            ),),
          ),

          Shimmer.fromColors( baseColor: Colors.black, highlightColor:Colors.white,child:Text('ENTER DETAILS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),),

          SizedBox(height: screenHeight*0.05,),


          Align(
            alignment: Alignment.centerLeft,
            child:Text("Hospital Details :" , style:TextStyle(fontWeight: FontWeight.bold))
          ),
          SizedBox(height: screenHeight*0.03,),

          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            controller: after_hos_name_controller,
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'eg : abc_hospital',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
            SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            controller: after_date_controller,
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'eg : 01/01/2024',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),

          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_place_controller,

            decoration: InputDecoration(
              hintText: 'eg : Agra',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_type_controller,

            decoration: InputDecoration(
              hintText: 'eg : Primary , Multispeciality',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),


         /*  Align(
            alignment: Alignment.centerLeft,
            child:Text("Treatments and Diagnosis :" , style:TextStyle(fontWeight: FontWeight.bold))
          ),
          SizedBox(height: screenHeight*0.03,),

          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'No. Of Diagnosis (surgeries , therapies)',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),

          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'Common Diagnosis',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'No. Of Newly Admitted',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,

            decoration: InputDecoration(
              hintText: 'No. Of Discharged',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),*/

           

          Align(
            alignment: Alignment.centerLeft,
            child:Text("Health Program Participation :" , style:TextStyle(fontWeight: FontWeight.bold))
          ),
          SizedBox(height: screenHeight*0.03,),
           Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_program_name_contoller,

            decoration: InputDecoration(
              hintText: 'Name of the program',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),

          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_no_parti_controller,

            decoration: InputDecoration(
              hintText: 'No. Of Participant in program',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_hours_controller,

            decoration: InputDecoration(
              hintText: 'No. Of hours taken',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.02,),
           Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: after_feedback_controller,

            decoration: InputDecoration(
              hintText: 'Feedback of program',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),

          SizedBox(height: screenHeight*0.04,),
           Align(
            alignment: Alignment.centerLeft,
            child:Text("Upload Program Image :" , style:TextStyle(fontWeight: FontWeight.bold))
          ),
          SizedBox(height: screenHeight*0.04,),


          Row(
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
            height: screenHeight*0.1,
            width: screenWidth*0.3,
            child: Icon(Icons.upload_rounded),
           // color: Colors.red,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
            ))
          ]),

          SizedBox(height: screenHeight*0.04,),



            GestureDetector(
              onTap:(){
                


                  if(after_formkey.currentState!.validate())
          {
            setState(() {
             
             after_hos_name = after_hos_name_controller.text.trim();
             after_program_name = after_program_name_contoller.text.trim();
             after_place = after_place_controller.text.trim();
             after_date = after_date_controller.text.trim();
             after_type = after_type_controller.text.trim();

              after_no_parti = after_no_parti_controller.text.trim();
             after_hours = after_hours_controller.text.trim();
             after_feedback = after_feedback_controller.text.trim();
           
            });
          }

          create_after(
             after_hos_name ,
             after_program_name ,
             after_place ,
             after_date ,
             after_type ,
             after_no_parti ,
             after_hours  ,
             after_feedback ,
            

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
      SizedBox(height: screenHeight*0.03,)
         
      ],)
    ))
    )
   )))));
  }
}