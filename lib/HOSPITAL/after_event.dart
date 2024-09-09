import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sih2024/FIREBASE/firebase_after_event.dart';
import 'package:sih2024/HOSPITAL/hos_main_page.dart';

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