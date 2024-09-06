import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/ADMIN/after_eventlist.dart';
import 'package:sih2024/ADMIN/hospital_list.dart';
import 'package:sih2024/ADMIN/program_list_admin.dart';
import 'package:sih2024/HOSPITAL/before_event.dart';
import 'package:sih2024/PUBLIC/new.dart';
import 'package:sih2024/PUBLIC/program_list.dart';

class admin_main_page extends StatefulWidget{
  @override
  State<admin_main_page> createState() => _admin_main_pageState();
}

class _admin_main_pageState extends State<admin_main_page> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.height;

   return Scaffold(
    backgroundColor: Colors.white,
    

    body:Container(child:Center(
      child:Column(
        children: [
          SizedBox(height: screenHeight*0.1,),
           Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.0, 
   
            child:Lottie.asset('assets/ANIMATION/8CnktyfBcv.json'),
            ),),
          ),

          SizedBox(height: screenHeight*0.08,),

          Container(
  height: 400,
  width: 300,
  //color: Colors.grey,
  child: GridView(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 150, // Adjusted for 2 columns, each item taking up max 150 width
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
    ),
    children: [
      GestureDetector(onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventsListPagess_admin()));
      },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
      child:Column(children:[
        SizedBox(height: screenHeight*0.09,),
        Icon(Icons.arrow_circle_left_outlined,color: Color.fromARGB(255, 3, 194, 9),),
          SizedBox(height: screenHeight*0.04,),
        Center(child: Text('Before Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))])
      ),),

      GestureDetector(onTap:(){
         Navigator.push(context, MaterialPageRoute(builder: (context) => EventsListPages()));
        
      },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child:Column( children:[
         SizedBox(height: screenHeight*0.09,),
        Icon(Icons.arrow_circle_right_outlined,color: Color.fromARGB(255, 3, 194, 9),),
         SizedBox(height: screenHeight*0.04,),
        Center(child: Text('After Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))])),),

       GestureDetector(onTap:(){
         Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalList()));

       },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child: Column(children:[
         SizedBox(height: screenHeight*0.09,),
        Icon(Icons.local_hospital_outlined,color: Color.fromARGB(255, 3, 194, 9),),
         SizedBox(height: screenHeight*0.04,),
        Center(child: Text('Hospital',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))]))),

GestureDetector(onTap:(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => before_event()));
},
  child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child:Column(children:[ 
         SizedBox(height: screenHeight*0.09,),
        Icon(Icons.add_circle_outline_outlined,color: Color.fromARGB(255, 3, 194, 9),),
         SizedBox(height: screenHeight*0.04,),
        Center(child: Text('New Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))]))),
    ],
  ),
)
        ],
      )
    ),)
   );
  }
}
