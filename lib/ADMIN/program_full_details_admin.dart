import 'package:flutter/material.dart';
import 'package:sih2024/FIREBASE/firebase_imp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventDetailPages_admin extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailPages_admin({required this.event});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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

            SizedBox(height: 50,),

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
      
      )),

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
