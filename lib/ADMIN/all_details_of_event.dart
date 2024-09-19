import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';
class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> event;
  final String program;
  final String hospital;
  EventDetailPage({required this.event , required this.program , required this.hospital});
  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}
class _EventDetailPageState extends State<EventDetailPage> {
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
    String imagePath = 'HOSPITAL_AFTER_EVENT_IMAGES/$programName.jpg'; // Construct image path dynamically

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
    var screenHeight = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child:Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Container(alignment: Alignment.center,
        child:Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight*0.17,),
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
                ? NetworkImage(imageUrl1) 
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

            SizedBox(height: screenHeight*0.08,),
            Align(alignment: Alignment.center,
              child:Text("${widget.event['Hospital_name']}".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
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
                      'Program :',
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
                    ),],), )),
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
                      'Conducted Date :',
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
                          prefixIcon: Icon(Icons.date_range,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Date Of Event']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
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
                      'Location :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_pin,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Location']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
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
                      'Type :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_hospital,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Type']}".toUpperCase() + " Hospital".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
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
                      'Participants :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.green
                          ),
                    ),
                    TextFormField(readOnly: true,
                    
                   
                      cursorColor: Colors.black,
                      style: TextStyle(
                        
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.group,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Participants']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
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
                      'Hours Taken :',
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
                          prefixIcon: Icon(Icons.timelapse,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Hours Taken']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
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
                     
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback :',
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
                          prefixIcon: Icon(Icons.feedback,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${widget.event['Feedback']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.08,),
                Align(alignment: Alignment.center,
              child:Text("Event Image :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),

               SizedBox(height: screenHeight*0.08,),

         GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InteractiveViewer(
          panEnabled: true, 
          minScale: 1.0,
          maxScale: 4.0, 
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.5, 
            decoration: BoxDecoration(
             
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.contain, 
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
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2.0), 
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



              
           
          ],
        ),
      ),
    ))));
  }
}
/*
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';

class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> event;
  final String program;

  EventDetailPage({required this.event, required this.program});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getImageUrl(widget.program); // Pass program name to getImageUrl
  }

  Future<void> getImageUrl(String programName) async {
    String imagePath = 'HOSPITAL_AFTER_EVENT_IMAGES/$programName.jpg'; // Construct image path dynamically

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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height; // Corrected to height
    var screenWidth = MediaQuery.of(context).size.width; // Corrected to width

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.17),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.blue[50],
                      backgroundImage: imageUrl.isEmpty
                          ? null
                          : NetworkImage(imageUrl),
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
                  SizedBox(height: screenHeight * 0.08),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.event['Hospital_name']}".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Program :',
                    icon: Icons.event,
                    text: "${widget.event['Program']}".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Conducted Date :',
                    icon: Icons.date_range,
                    text: "${widget.event['Date Of Event']}".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Location :',
                    icon: Icons.location_pin,
                    text: "${widget.event['Location']}".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Type :',
                    icon: Icons.local_hospital,
                    text: "${widget.event['Type']}".toUpperCase() + " Hospital".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Participants :',
                    icon: Icons.group,
                    text: "${widget.event['Participants']}".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Hours Taken :',
                    icon: Icons.timelapse,
                    text: "${widget.event['Hours Taken']}".toUpperCase(),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  _buildDetailContainer(
                    title: 'Feedback :',
                    icon: Icons.feedback,
                    text: "${widget.event['Feedback']}".toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailContainer({required String title, required IconData icon, required String text}) {
    return Container(
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
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.green,
              ),
            ),
            TextFormField(
              readOnly: true,
              cursorColor: Colors.black,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Colors.green),
                prefixIconColor: Colors.black,
                hintText: text,
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
