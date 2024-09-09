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

       Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blueGrey,
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
              SizedBox(height: screenHeight*0.06,),
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
    ));
  }
}
