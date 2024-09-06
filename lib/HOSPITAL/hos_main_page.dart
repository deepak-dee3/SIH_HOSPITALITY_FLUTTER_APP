import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sih2024/HOSPITAL/after_event.dart';
import 'package:sih2024/HOSPITAL/before_event.dart';
import 'package:lottie/lottie.dart';

class hos_opening_page extends StatefulWidget{
  @override
  State<hos_opening_page> createState() => _hos_opening_pageState();
}

class _hos_opening_pageState extends State<hos_opening_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:/*GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => before_event()));
      },
        child:*/Padding(padding: EdgeInsets.all(16),child:Center(child:Container(child:Column(

          children: [

            SizedBox(height: 50,),

            Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.5, 
   
            child:Lottie.asset('assets/ANIMATION/Animation - 1724386421518.json'),
            ),),
          ),

          SizedBox(height: 50,),

         

            GestureDetector(
            onTap:(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => before_event()));

            },
            child: Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child:Padding(padding: EdgeInsets.only(left:15),
                  child:Shimmer.fromColors(period: Duration(seconds: 9), baseColor: Colors.black, highlightColor: Colors.white,child:
                  Text('Upload about Program',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),)),)
            )),

            SizedBox(height: 50,),

             GestureDetector(
            onTap:(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => enter_details_hospoital()));

            },
            child: Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child:Padding(padding: EdgeInsets.only(left:15),
                  child:Shimmer.fromColors( period: Duration(seconds: 9),
                    baseColor: Colors.black, highlightColor: Colors.white,child:
                  Text('Update about Program',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),)),
            )),),

            SizedBox(height: 50,),

          ]
        ))))
        )
    ;
  }
}