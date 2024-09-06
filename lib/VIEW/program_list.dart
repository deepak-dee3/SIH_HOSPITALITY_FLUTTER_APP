import 'package:flutter/material.dart';

class program_list extends StatefulWidget{
  @override
  State<program_list> createState() => _program_listState();
}

class _program_listState extends State<program_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
         Padding(padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),
            height:100,width: 100,),),
          SizedBox(height:10),
           Padding(padding: EdgeInsets.all(16),
          child: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),height:100,width: 100,),),
          SizedBox(height:10), 
          Padding(padding: EdgeInsets.all(16),
          child: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),height:100,width: 100,),),
          SizedBox(height:10),
           
        ],
      ),
    );
  }
}