// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:sih2024/my_encryption.dart';

// class encrypt_checking extends StatefulWidget{
//   @override
//   State<encrypt_checking> createState() => _encrypt_checkingState();
// }

// class _encrypt_checkingState extends State<encrypt_checking> {

//   TextEditingController a= TextEditingController();
//   var encr,pl;


//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(

//     body:SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child:Center(child:Column(children: [

//         SizedBox(height:100),

//         TextField(
//           controller: encr,
//           decoration: InputDecoration(
//             hintText: "WRITE HERE"
//           ),

//         ),

//         SizedBox(height: 20,),

//         ElevatedButton(onPressed: ()
// {
//   pl = encr.text;
// }        , child: Text('click'))

//       ],))
//     )


//    );
//   }
// }

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'my_encryption.dart';




class HomePage11 extends StatefulWidget {
  @override
  _HomePage11State createState() => _HomePage11State();
}

class _HomePage11State extends State<HomePage11> {
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption/Decryption"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: tec,
              ),
            ),
            Column(
              children: [
                Text(
                  "PLAIN TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(plainText == null ? "" : plainText),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "ENCRYPTED TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(encryptedText == null
                      ? ""
                      : encryptedText is encrypt.Encrypted
                          ? encryptedText.base64
                          : encryptedText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    plainText = tec.text;
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.encryptFernet(plainText);
                    });
                   
                    tec.clear();
                  },
                  child: Text("Encrypt"),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.decryptFernet(encryptedText);
                      print("Type: " + encryptedText.runtimeType.toString());
                    });
                  },
                  child: Text("Decrypt"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}