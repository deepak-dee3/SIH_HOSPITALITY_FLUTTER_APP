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
import 'package:intl/intl.dart';

class before_event extends StatefulWidget{
  @override
  State<before_event> createState() => before_event_pageState();
}

class before_event_pageState extends State<before_event> {


   String before_hos_name =' ',before_program_name =' ',before_place=' ',before_date=' ',before_availability=' ',before_sd=' ',before_dis=' ',before_state=' ',
   before_mode=' ',before_sponser=' ',before_sp_amount=' ';
 

  TextEditingController before_hos_name_controller = TextEditingController();
  TextEditingController before_program_name_contoller = TextEditingController();
  TextEditingController before_place_controller = TextEditingController();
  TextEditingController before_date_contoller = TextEditingController();
  TextEditingController before_availability_controller = TextEditingController();
  TextEditingController before_sub_dis_controller = TextEditingController();
  TextEditingController before_dis_contoller = TextEditingController();
  TextEditingController before_state_or_union_controller = TextEditingController();
   TextEditingController before_sponser_controller = TextEditingController();
  TextEditingController before_sponser_amount_contoller = TextEditingController();
  TextEditingController before_mode_controller = TextEditingController();

  
  

  final before_formkey = GlobalKey<FormState>();

 
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
      if (_pickedImage == null) {
        Fluttertoast.showToast(msg: 'Please pick an image');
        return;
      }
      if(before_availability_controller.text.isEmpty || before_date_contoller.text.isEmpty || before_dis_contoller.text.isEmpty || before_hos_name_controller.text.isEmpty || before_place_controller.text.isEmpty || before_program_name_contoller.text.isEmpty || before_state_or_union_controller.text.isEmpty || before_sub_dis_controller.text.isEmpty || before_mode_controller.text.isEmpty || before_sponser_amount_contoller.text.isEmpty || before_sponser_controller.text.isEmpty)
      {
         Fluttertoast.showToast(msg: 'Please fill all the details');
        return;

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
             before_mode,
             before_sponser,
             before_sp_amount,

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
    //  final hos_name = "${before_hos_name_controller.text}_${before_program_name_contoller.text}_${before_date_contoller.text}";
       final prog = "${before_program_name_contoller.text.toLowerCase()}";

      Reference image_ref = FirebaseStorage.instance.ref().child('HOSPITAL_BEFORE_EVENT_IMAGES/$prog.jpg');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      await image_ref.putFile(compressedFile, metadata).whenComplete(() async {
        imageurl = await image_ref.getDownloadURL();
        before_hos_name_controller.clear();
        
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => hos_opening_page()),
        (route) => false,
      );


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
    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child:Scaffold(
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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the name of the hospital *";
                    }
                    
                   
                   
                    return null;
                  },

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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the name of the program *";
                    }
                    
                   
                   
                    return null;
                  },

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
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the place of the hospital *";
                    }
                    
                   
                   
                    return null;
                  },

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
           

validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the date that will be conducted *";
  }

  // Define the date format
  final DateFormat format = DateFormat('dd/MM/yyyy');

  // Try to parse the value to a date
  try {
    format.parseStrict(value);
  } catch (e) {
    return "Enter a valid date (format: dd/MM/yyyy) *";
  }

  return null;
},


            decoration: InputDecoration(
              hintText: 'eg : 01/01/2024',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),
          SizedBox(height: screenHeight*0.04,),

           Align(alignment: Alignment.centerLeft,child:Text("Sponser By :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_sponser_controller,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the organisation / institution name *";
                    }
                    
                   
                   
                    return null;
                  },

            decoration: InputDecoration(
              hintText: 'eg : abc groups',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),SizedBox(height: screenHeight*0.04,),

           Align(alignment: Alignment.centerLeft,child:Text("Sponser Amount :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
             keyboardType: TextInputType.number,
            controller: before_sponser_amount_contoller,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the sponser amount by organisation / institution *";
                    }
                    
                   
                   
                    return null;
                  },

            decoration: InputDecoration(
              hintText: 'eg : 1,00,000',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),SizedBox(height: screenHeight*0.04,),

            Align(alignment: Alignment.centerLeft,child:Text("Program Mode :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
           //  keyboardType: TextInputType.number,
            controller: before_mode_controller,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the mode of the program *";
                    }
                    
                   
                   
                    return null;
                  },

            decoration: InputDecoration(
              hintText: 'eg : Free / Paid + amount',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left:10,top: 13),
              
              
            ),

          )
          ),SizedBox(height: screenHeight*0.04,),


          Align(alignment: Alignment.centerLeft,child:Text("Availability :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

           SizedBox(height: screenHeight*0.02,),
          Container(height: screenHeight*0.08,width: screenWidth*0.8,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          child:TextFormField(
            cursorColor: Colors.black,
            controller: before_availability_controller,
           keyboardType: TextInputType.number,
             validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter the No.of vaccancies alloted for the program *";
                    }
                    
                   
                   
                    return null;
                  },

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
             validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the sub district *";
  }

  // Check if the value contains only letters and spaces
  final validSubDistrictRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!validSubDistrictRegExp.hasMatch(value)) {
    return "Enter a valid sub district name *";
  }

  return null;
},


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
            validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the district *";
  }

  // Check if the value contains only letters and spaces
  final validSubDistrictRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!validSubDistrictRegExp.hasMatch(value)) {
    return "Only contains a-z*";
  }

  return null;
},


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
             validator: (value) {
  if (value == null || value.isEmpty) {
    return "Enter the state / union territory name *";
  }

  // Check if the value contains only letters and spaces
  final validSubDistrictRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!validSubDistrictRegExp.hasMatch(value)) {
    return "Only contains a-z *";
  }

  return null;
},


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
              onTap: (){
                pickimage_cam();
              },
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
              onTap: (){
                pickimage();
              }
               
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
             before_mode = before_mode_controller.text.trim();
             before_sponser = before_sponser_controller.text.trim();
             before_sp_amount = before_sponser_amount_contoller.text.trim();

            });
          }
           
                uploadfirebase();


                
         

         /*  Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => hos_opening_page()),
        (route) => false,
      );*/

         


              
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
    ))));
  }
}