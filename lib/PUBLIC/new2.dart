import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';


class EventDetailPages extends StatefulWidget {
  final Map<String, dynamic> event;
   final String hospital;

  EventDetailPages({required this.event , required this.hospital});

  @override
  State<EventDetailPages> createState() => _EventDetailPagesState();
}

class _EventDetailPagesState extends State<EventDetailPages> {

  final translator = GoogleTranslator();

  bool isEnglish = true;
  bool isHindi = true;
  String originalProgram = '';
  String originalHospitalName = '';
  String originalLocation = '';
  String originalDateOfEvent = '';
  String originalAvailability = '';
  String originalMode = '';
  String originalTitle = 'Event Details';
   String translatedTitle = '';
  


  String translatedProgram = '';
  String translatedHospitalName = '';
  String translatedLocation = '';
  String translatedDateOfEvent = '';
  String translatedAvailability = '';
  String translatedMode = '';

   @override
  void initState() {
    super.initState();
     getImageUrl(widget.hospital);
    // Initialize fields with original data
    originalProgram = widget.event['Program'];
    originalHospitalName = widget.event['Hospital_name'];
    originalLocation = widget.event['Location'];
    originalDateOfEvent = widget.event['Date Of Event'];
    originalAvailability = widget.event['Availability'];
    originalMode = widget.event['Mode_of_program'];
    
    // Set translated fields to initial values
    translatedProgram = originalProgram;
    translatedHospitalName = originalHospitalName;
    translatedLocation = originalLocation;
    translatedDateOfEvent = originalDateOfEvent;
    translatedAvailability = originalAvailability;
    translatedMode = originalMode;
    translatedTitle = originalTitle;
  }

  void translateFields(String targetLang) async {
    final programTranslation = await translator.translate(originalProgram, to: targetLang);
    final hospitalTranslation = await translator.translate(originalHospitalName, to: targetLang);
    final locationTranslation = await translator.translate(originalLocation, to: targetLang);
    final dateOfEventTranslation = await translator.translate(originalDateOfEvent, to: targetLang);
    final availabilityTranslation = await translator.translate(originalAvailability, to: targetLang);
    final modeTranslation = await translator.translate(originalMode,to: targetLang);
    final titleTranslation = await translator.translate(originalTitle, to: targetLang);


    setState(() {
      translatedProgram = programTranslation.text;
      translatedHospitalName = hospitalTranslation.text;
      translatedLocation = locationTranslation.text;
      translatedDateOfEvent = dateOfEventTranslation.text;
      translatedAvailability = availabilityTranslation.text;
      translatedMode = modeTranslation.text;
      translatedTitle = titleTranslation.text;
    });
  }

  void toggleLanguage() {
    if (isEnglish) {
      translateFields('hi');

    } 
   /* else if(isHindi)
    {
      translateFields('mr');
    }*/
    else {
      // Set back to original English values
      setState(() {
        translatedProgram = originalProgram;
        translatedHospitalName = originalHospitalName;
        translatedLocation = originalLocation;
        translatedDateOfEvent = originalDateOfEvent;
        translatedAvailability = originalAvailability;
        translatedMode = originalMode;
        translatedTitle = originalTitle;
      });
    }
    setState(() {
      isEnglish = !isEnglish;
    });
  }
   String imageUrl = '';


  Future<void> getImageUrl(String programName) async {
    String imagePath = 'HOSPITAL_IMAGES/$programName.jpg'; // Construct image path dynamically

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
    var screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(translatedTitle.toUpperCase(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.translate , color:const Color.fromARGB(255, 168, 17, 6)),
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body:SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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
          child: CircleAvatar(
            radius: screenHeight * 0.25, // Adjust size as needed
            backgroundImage: imageUrl.isNotEmpty 
                ? NetworkImage(imageUrl) 
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
      backgroundImage: imageUrl.isNotEmpty
          ? NetworkImage(imageUrl)
          : null,
      backgroundColor: Colors.blue[50], // Blue background when no image
      child: imageUrl.isEmpty
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
                         // hintText: "${widget.event['Program']}".toUpperCase(),
                         hintText: "${translatedProgram}".toUpperCase(),
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
                         // hintText: "${widget.event['Location']}".toUpperCase(),
                         hintText: "${translatedLocation}".toUpperCase(),
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
                      'Program Mode (Free / Paid) :',
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
                          prefixIcon: Icon(Icons.currency_rupee,color: Colors.green,),
                         
                          prefixIconColor: Colors.black,
                          hintText: "${translatedMode}".toUpperCase() ,
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
            // Add more details as needed
          ],
        ),
      ),
    )));
  }
}




/*import 'package:flutter/material.dart';

class EventDetailPages extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailPages({required this.event});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event Details'),
        backgroundColor: Colors.blue,
      ),
      body:SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: screenHeight*0.06,),

            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.js_m--7-FZoWCNrtRA-kQwHaFj?w=205&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
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
                          hintText: "${event['Program']}".toUpperCase(),
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
                          hintText: "${event['Hospital_name']}".toUpperCase(),
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
                          hintText: "${event['Location']}".toUpperCase(),
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
                          hintText: "${event['Date Of Event']}".toUpperCase(),
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
                          hintText: "${event['Availability']}".toUpperCase(),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
            // Add more details as needed
          ],
        ),
      ),
    ));
  }
}*/

//////////////////////////////////////////

