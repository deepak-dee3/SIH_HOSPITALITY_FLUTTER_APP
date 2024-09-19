import 'package:flutter/material.dart';
import 'package:sih2024/FIREBASE/firebase_imp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';

class EventDetailPages_admin extends StatefulWidget {
  final Map<String, dynamic> event;
   final String program;
    final String hospital;

  EventDetailPages_admin({required this.event , required this.program ,required this.hospital});

  @override
  State<EventDetailPages_admin> createState() => _EventDetailPages_adminState();
}

class _EventDetailPages_adminState extends State<EventDetailPages_admin> {

   String imageUrl = '';
    String imageUrl1 = '';

  @override
  void initState() {
    super.initState();
    getImageUrl(widget.program);
    getImageUrl1(widget.hospital);
    
     // Pass program name to getImageUrl
  }

  Future<void> getImageUrl(String programName) async {
    String imagePath = 'HOSPITAL_BEFORE_EVENT_IMAGES/$programName.jpg'; // Construct image path dynamically

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(imagePath);
      final url = await ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
      print('Image URL: $url');
    } catch (e) {
      print('Error getting image URL: $e');
      if (e is firebase_storage.FirebaseException) {
        print('Firebase Storage Error: ${e.code}');
        print('Message: ${e.message}');
      } else {
        print('Unknown Error: $e');
      }
      // Provide a placeholder or default image if the image is not found
      setState(() {
        imageUrl = ''; // Optionally set a placeholder image URL here
      });
    }
  }
   Future<void> getImageUrl1(String programName1) async {
    String imagePath1 = 'HOSPITAL_IMAGES/$programName1.jpg'; // Construct image path dynamically

    try {
      final ref1 = firebase_storage.FirebaseStorage.instance.ref(imagePath1);
      final url1 = await ref1.getDownloadURL();
      setState(() {
        imageUrl1 = url1;
      });
      print('Image URL: $url1');
    } catch (e) {
      print('Error getting image URL: $e');
      if (e is firebase_storage.FirebaseException) {
        print('Firebase Storage Error: ${e.code}');
        print('Message: ${e.message}');
      } else {
        print('Unknown Error: $e');
      }
      // Provide a placeholder or default image if the image is not found
      setState(() {
        imageUrl1 = ''; // Optionally set a placeholder image URL here
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /* Text(
              event['Program'] ?? 'No Program Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Hospital: ${event['Hospital_name'] ?? 'No Hospital Name'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Date: ${event['Date Of Event'] ?? 'No Date'}',
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 90,),

             GestureDetector(

              onTap: (){
                 Fluttertoast.showToast(
      msg: 'Make Double tap to delete the program',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
                print('Make Double tap to delete the program ');
              },
              
              onDoubleTap:(){
                
                delete("BEFORE EVENT",event['Program']);

              //  Navigator.push(context,MaterialPageRoute(builder: (context) => enter_details_hospoital()));

               
              },child:Container(alignment: Alignment.center,
      height:  screenHeight * 0.08,
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
        //color: const Color.fromARGB(255, 13, 124, 17),
        color:const Color.fromARGB(255, 195, 28, 16)
       
      
      ),child:
      
        Text('Delete Program',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17,))
      
      )),*/

        GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InteractiveViewer(
          panEnabled: true, // Enables panning (dragging)
          minScale: 1.0,
          maxScale: 4.0, // Allows zooming up to 4x
          child: CircleAvatar(
            radius: screenHeight * 0.25, // Adjust size as needed
            backgroundImage: imageUrl1.isNotEmpty 
                ? NetworkImage(imageUrl1,scale: 1.0) 
                : null,
            backgroundColor: Colors.blue[50], // Background color for empty image
          ),
        ),
      ),
    );
  },
  child: Align(
    alignment: Alignment.center,
    child: CircleAvatar(
      radius: 100, // Adjust radius as needed
      backgroundImage: imageUrl1.isNotEmpty
          ? NetworkImage(imageUrl1)
          : null,
      backgroundColor: Colors.blue[50], // Blue background when no image
      child: imageUrl1.isEmpty
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    ),
  ),
),

             SizedBox(height: screenHeight*0.06,),
           
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
                      'Program Name :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Program']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),

            SizedBox(height: screenHeight *0.04),
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
                      'Hospital Name :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_hospital,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Hospital_name']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),

            SizedBox(height: screenHeight*0.04),
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
                      'Location :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Location']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
               SizedBox(height: screenHeight *0.04),
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
                      'Date Of Event :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Date Of Event']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight *0.04),
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
                      'Sponser By :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Sponser']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight *0.04),
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
                      'Sponser Amount :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Sponser_amount']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight *0.04),
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
                      'Program Mode :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Mode_of_program']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
               SizedBox(height: screenHeight *0.04),
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
                      'Availability :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(
                      readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.event,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Availability']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.06,),
               Align(alignment: Alignment.center,
              child:Text("Event Proof / Permit :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),

               SizedBox(height: screenHeight*0.06,),
               GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InteractiveViewer(
          panEnabled: true, // Enables panning (dragging)
          minScale: 1.0,
          maxScale: 4.0, // Allows zooming up to 4x
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.5, // Adjust size as needed
            decoration: BoxDecoration(
             
              image: DecorationImage(
                image: NetworkImage(imageUrl,scale:1.0),
                fit: BoxFit.contain, // Ensures the full image is shown
              ),
            ),
          ),
        ),
      ),
    );
  },
  child: Align(
    alignment: Alignment.center,
    child: Container(
      width: double.infinity,
      height: 300, // Adjust height as needed
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2.0), // Blue border
        image: imageUrl.isEmpty
            ? null
            : DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
      ),
      child: imageUrl.isEmpty
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              ),
            )
          : null,
    ),
  ),
),

SizedBox(height: screenHeight*0.1,),

              GestureDetector(

              onTap: (){
                 Fluttertoast.showToast(
      msg: 'Make Double tap to delete the program',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
                print('Make Double tap to delete the program ');
              },
              
              onDoubleTap:(){
                
                delete("BEFORE EVENT",widget.event['Program']);

              //  Navigator.push(context,MaterialPageRoute(builder: (context) => enter_details_hospoital()));

               
              },child:Container(alignment: Alignment.center,
      height:  screenHeight * 0.08,
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
        //color: const Color.fromARGB(255, 13, 124, 17),
        color:const Color.fromARGB(255, 195, 28, 16)
       
      
      ),child:
      
        Text('Delete Program',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17,))
      
      )),

            // Add more details as needed
          ],
        ),
      ),
    )));
  }
}
