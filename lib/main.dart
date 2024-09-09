import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sih2024/ADMIN/admin_main_page.dart';
import 'package:sih2024/ADMIN/after_eventlist.dart';
import 'package:sih2024/FORGET%20PASSWORD/forget_password.dart';
import 'package:sih2024/HOSPITAL/hos_main_page.dart';
import 'package:sih2024/PUBLIC/new.dart';
import 'package:sih2024/PUBLIC/program_list.dart';
import 'package:sih2024/sign_up_page.dart';
import 'firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2024/HOSPITAL/after_event.dart';
import 'package:sih2024/HOSPITAL/before_event.dart';
import 'package:sih2024/VIEW/program_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'FIREBASE/abc.dart';
import 'package:shimmer/shimmer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:LoginPage(),
      debugShowCheckedModeBanner: false,
    );   
  }
}
class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String login_email = ' ', login_pass = ' '; 
  final String passkey = '123';
   String? passkeyError;
 

  TextEditingController login_emailcontroller = TextEditingController();
  TextEditingController login_passcontroller = TextEditingController();
    TextEditingController passkeyController = TextEditingController();

  

  final login_formkey = GlobalKey<FormState>();

 
      userlogin() async {
        
    try {
      
      if (login_email.isNotEmpty && login_pass.isNotEmpty ) { // Check if both email and password are provided
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: login_email, password: login_pass);
       
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>hos_opening_page() ,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(microseconds: 1),
          ),
        );
        login_emailcontroller.clear();
        login_passcontroller.clear();
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email and password')));
      }
    } on FirebaseAuthException catch (e) {
    print('FirebaseAuthException: ${e.code}'); // Logging the error code for debugging
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No User found for that Email',
              style: TextStyle(fontSize: 20))));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Wrong Password provided by user',
              style: TextStyle(fontSize: 20))));
    } else {
      Fluttertoast.showToast(
  msg: "Error in your mail and password",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.TOP,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 15.0
);
    }
  } catch (e) {
    print('Exception: $e'); // Logging the general error for debugging
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again.',
            style: TextStyle(fontSize: 20))));
  }
}
  
  
  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width; 
    var screenHeight = MediaQuery.of(context).size.height;
    

   return Scaffold(
    backgroundColor: Colors.white,
    

    body:Padding(padding:EdgeInsets.all(16),child:Center(
      child:Container(height: screenHeight*2,width: screenWidth*9,
      color: Colors.white,
      child:
    SingleChildScrollView(scrollDirection: Axis.vertical,child:Form(key:login_formkey,
      child:Column(

        children: [
          SizedBox(height: screenHeight*0.06,),

         // Padding(padding: EdgeInsets.only(left: screenWidth*2) , child:Text('LOGIN PAGE',style: TextStyle(color:Colors.black),))
         
        /*   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Text('USER LOGIN',style:TextStyle(fontWeight: FontWeight.bold , fontSize: 18)),

             Text('SIGN UP',style:TextStyle(fontWeight: FontWeight.bold , fontSize: 18))

            ],

          ),*/
          GestureDetector(onTap:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => sign_up()));
          },
            child:
Align(
  alignment: Alignment.centerRight,
  child: Shimmer.fromColors(
    baseColor: Colors.green, // The base color of the shimmer
    highlightColor: Colors.lightGreenAccent, // The highlight color
    child: Text(
      'SIGN UP',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromARGB(255, 13, 124, 17), // Text color
      ),
    ),
  ),
),          ),


           Center(child: Container(
            height: 250,
            width: 100,child:Transform.scale(
            scale: 3.0, 
   
            child:Lottie.asset('assets/ANIMATION/Animation - 1723966936917.json'),
            ),),
          ),

          //SizedBox(height:screenHeight*0.01),

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
                      "Hospital Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                       controller: login_emailcontroller,
               
                    // controller: login_emailcontroller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your user email";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.black,
                          hintText: "Email",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),
              SizedBox(height: screenHeight*0.05,),
               Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                 color: Colors.blue.withOpacity(0.2),
                // color: Color.fromARGB(255, 15, 190, 21),
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
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                         // color: Color(0xff67727d)
                         color:Colors.black
                          ),
                    ),
                    TextFormField(
                     controller: login_passcontroller,
                validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return "Enter your user password";
                    }
                    
                   
                   
                    return null;
                  },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Colors.black,
                          hintText: "Password",
                          border: InputBorder.none),
                    ),
                  ],
                ),
              )),

              SizedBox(height: screenHeight*0.04,),

            GestureDetector(onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => forgetpassword()));
            },
              child:  Align(
                alignment: Alignment.center,
                child:Text('FORGOT PASSWORD ?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)

              ),),
              SizedBox(height: screenHeight*0.04,),


              GestureDetector(
              onTap:(){

              //  Navigator.push(context,MaterialPageRoute(builder: (context) => enter_details_hospoital()));

                if(login_formkey.currentState!.validate())
          {
            setState(() {
              login_email = login_emailcontroller.text.trim();
              
              login_pass = login_passcontroller.text.trim();

            });
            userlogin();
          }

         // userlogin();
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
        color: const Color.fromARGB(255, 13, 124, 17),
       
      
      ),child:
      
        Text('Log In',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17,))
      
      )),

      SizedBox(height: screenHeight*0.03,),

       Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
        onTap:(){
         // Navigator.push(context, MaterialPageRoute(builder: (context) =>admin_main_page()));
         
         showDialog(
      context: context,
      builder: (BuildContext context) {
        String? passkeyError;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shadowColor: Colors.blue,
              backgroundColor: Color.fromARGB(255, 10, 132, 232),
              title: Row(children: [

                Shimmer.fromColors( baseColor:Colors.black, highlightColor: Colors.green,child:Icon(Icons.lock,size: 30,),),
                SizedBox(width: 10,),
                Text('Secure Key',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

              ],),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: TextStyle(color:Colors.white),
                    controller: passkeyController,
                    keyboardAppearance: Brightness.light,
                   
                    decoration: InputDecoration(
                     
                      hintText: 'Enter the pass key',hintStyle: TextStyle(color: Colors.white)),
                  ),
                  if (passkeyError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        passkeyError!,
                        style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Shimmer.fromColors(baseColor: Colors.green, highlightColor: Colors.white,child:Text('Submit',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),),
                  onPressed: () {
                    if (passkeyController.text.trim() == passkey) {
                      passkeyController.clear(); // Clear the passkey field
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                        context,
                         PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => admin_main_page(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = 0.0;
                          const end = 1.0;
                          const curve = Curves.elasticIn;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var opacityAnimation = animation.drive(tween);

                          return FadeTransition(
                            opacity: opacityAnimation,
                            child: child,
                          );
                        },
                      ),
                      );
                    } else {
                      passkeyController.clear();
                      setState(() {
                        passkeyError = 'Enter correct pass key';
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );

            

        },

        child:

            Row(children: [

            Icon(Icons.admin_panel_settings,size: 45,color: const Color.fromARGB(255, 198, 26, 13),),
           Shimmer.fromColors(
  baseColor: Colors.black, 
  highlightColor: Colors.white, 
  child: Text(
    'ADMIN',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15, 
    ),
  ),
),
            ]),),

            GestureDetector(
        onTap:(){
           Navigator.push(context,MaterialPageRoute(builder: (context) => EventsListPagess()));

             //           Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));


        },

        child:
 
            Row(
              children: [
                Icon(Icons.person_2_rounded,size: 40,color: const Color.fromARGB(255, 198, 26, 13),),
           Shimmer.fromColors(
  baseColor: Colors.black, 
  highlightColor: Colors.grey, 
  child: Text(
    'PUBLIC',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15, 
    ),
  ),
),

              ],

            )),
          ],
        ),
      



        ],
      )
      )),)



   
    
   )));
  }
}