import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sih2024/HOSPITAL/after_event.dart';
import 'package:sih2024/HOSPITAL/before_event.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/HOSPITAL/modify_hos_event.dart';
import 'package:sih2024/HOSPITAL/view_prog_list.dart';
import 'package:sih2024/main.dart';

class hos_opening_page extends StatefulWidget{
  @override
  State<hos_opening_page> createState() => _hos_opening_pageState();
}

class _hos_opening_pageState extends State<hos_opening_page> {

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace MainPage with your actual main page widget
    );
    return false; // Prevents the default back button action
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
      child:  Scaffold(
    backgroundColor: Colors.white,
    

    body:Container(child:Center(
      child:Column(
        children: [
          SizedBox(height: screenHeight*0.08,),
           Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.0, 
   
            child:Lottie.asset('assets/ANIMATION/Animation - 1726551103782.json'),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => before_event()));
      },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
      child:Column(children:[
        SizedBox(height: screenHeight*0.04,),
        Icon(Icons.add_circle_outline_outlined,color: Color.fromARGB(255, 3, 194, 9),size: 30,),
          SizedBox(height: screenHeight*0.02,),
        Center(child: Text('Upload Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))])
      ),),

      GestureDetector(onTap:(){
         Navigator.push(context, MaterialPageRoute(builder: (context) => enter_details_hospoital()));
        
      },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child:Column( children:[
         SizedBox(height: screenHeight*0.04,),
        Icon(Icons.outbox_outlined,color: Color.fromARGB(255, 3, 194, 9),size: 30,),
         SizedBox(height: screenHeight*0.02,),
        Center(child: Text('Report Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))])),),

       GestureDetector(onTap:(){
       //  Navigator.push(context, MaterialPageRoute(builder: (context) => BeforeEventModify()));

       },
        child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child: Column(children:[
         SizedBox(height: screenHeight*0.04,),
        Icon(Icons.change_circle_outlined,color: Color.fromARGB(255, 3, 194, 9),size: 30,),
         SizedBox(height: screenHeight*0.02,),
        Center(child: Text('Modify Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))]))),

GestureDetector(onTap:(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => EventsListPagess_hospital()));
},
  child:
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue), child:Column(children:[ 
         SizedBox(height: screenHeight*0.04,),
        Icon(Icons.view_agenda_outlined,color: Color.fromARGB(255, 3, 194, 9),size: 30,),
         SizedBox(height: screenHeight*0.02,),
        Center(child: Text('View Event',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))]))),
    ],
  ),
)
        ],
      )
    ),)
   ));




    /* WillPopScope( onWillPop: _onWillPop,
      child: 
     Scaffold(
      backgroundColor: Colors.white,
      body:/*GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => before_event()));
      },
        child:*/Padding(padding: EdgeInsets.all(16),child:Center(child:Container(child:Column(

          children: [

            SizedBox(height: screenHeight*0.05,),

            Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 2.5, 
   
            child:Lottie.asset('assets/ANIMATION/Animation - 1726551103782.json'),
            ),),
          ),

          SizedBox(height: screenHeight*0.05,),

         

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
                  Text('Upload New Program',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),)),)
            )),

            SizedBox(height: screenHeight*0.05,),

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
                  Text('Update About Program',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),)),
            )),),

            SizedBox(height: screenHeight*0.05,),

              GestureDetector(
            onTap:(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => EventsListPagess_hospital()));

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
                  Text('View All Programs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),)),
            )),),

            SizedBox(height: screenHeight*0.05,),

            
          ]
        ))))
        )
    );*/
  }
}