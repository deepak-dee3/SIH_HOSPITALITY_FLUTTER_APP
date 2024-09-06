import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/FIREBASE/firebase_before.dart';
import 'package:sih2024/HOSPITAL/hos_main_page.dart';
import 'package:quickalert/quickalert.dart';

class before_event extends StatefulWidget{
  @override
  State<before_event> createState() => before_event_pageState();
}

class before_event_pageState extends State<before_event> {


   String before_hos_name =' ',before_program_name =' ',before_place=' ',before_date=' ',before_availability=' ';
 

  TextEditingController before_hos_name_controller = TextEditingController();
  TextEditingController before_program_name_contoller = TextEditingController();
  TextEditingController before_place_controller = TextEditingController();
  TextEditingController before_date_contoller = TextEditingController();
  TextEditingController before_availability_controller = TextEditingController();
  
  

  final before_formkey = GlobalKey<FormState>();



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

          SizedBox(height: screenHeight*0.06,),

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

            });
          }

          create(
            before_hos_name ,
             before_program_name ,
             before_place,
             before_date ,
             before_availability ,

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