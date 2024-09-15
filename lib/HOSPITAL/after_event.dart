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
  
 String? imageurl;
  final ImagePicker _imagepic = ImagePicker();
 // TextEditingController _campeve_controller = TextEditingController();

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
       if (after_date_controller.text.isEmpty || after_feedback_controller.text.isEmpty || after_hos_name_controller.text.isEmpty || after_hours_controller.text.isEmpty || after_no_parti_controller.text.isEmpty || after_place_controller.text.isEmpty || after_program_name_contoller.text.isEmpty || after_type_controller.text.isEmpty ) {
        Fluttertoast.showToast(msg: 'Please fill all the details');
        return;
      }
       if (_pickedImage == null) {
        Fluttertoast.showToast(msg: 'Please pick an image');
        return;
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

      

      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Submitting Data...',
      );

      File compressedFile = await compressImage(_pickedImage!);

      final now = DateTime.now();
     // final formattedDate = "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";
      final hos_name = "${after_hos_name_controller.text}_${after_program_name_contoller.text}_${after_date_controller.text}";
       final program_name = "${after_program_name_contoller.text}";
        final date = "${after_date_controller.text}";

      Reference image_ref = FirebaseStorage.instance.ref().child('HOSPITAL_AFTER_EVENT_IMAGES/$hos_name.jpg');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      await image_ref.putFile(compressedFile, metadata).whenComplete(() async {
        imageurl = await image_ref.getDownloadURL();
        after_hos_name_controller.clear();
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => hos_opening_page()));

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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the name of the hospital *";
                    }
                    
                   
                   
                    return null;
                  },
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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the date program been happened *";
                    }
                    
                   
                   
                    return null;
                  },
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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the location of your hospital *";
                    }
                    
                   
                   
                    return null;
                  },

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
             validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the type of your hospital *";
  }

  // Check if the value contains only letters and spaces
  final validSubDistrictRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!validSubDistrictRegExp.hasMatch(value)) {
    return "Enter valid type of your hospital *";
  }

  return null;
},


            decoration: InputDecoration(
              hintText: 'eg : Primary , Multispeciality',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
           SizedBox(height: screenHeight*0.04,),

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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the program name *";
                    }
                    
                   
                   
                    return null;
                  },

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
            keyboardType: TextInputType.number,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter No. of participants attended *";
                    }
                    
                   
                   
                    return null;
                  },

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
            keyboardType: TextInputType.number,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter No.of hours taken *";
                    }
                    
                   
                   
                    return null;
                  },

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
               validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the feedback about the program *";
  }

  // Check if the value contains only letters and spaces
  final validSubDistrictRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!validSubDistrictRegExp.hasMatch(value)) {
    return "Does not contain numbers *";
  }

  return null;
},

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
            GestureDetector(onTap:pickimage,
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
         
                


                 
           
      uploadfirebase();
          


              
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