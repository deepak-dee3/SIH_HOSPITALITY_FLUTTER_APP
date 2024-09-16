/*import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class ProgramTranslation extends StatefulWidget {
  final Map<String, dynamic> event;

  ProgramTranslation({required this.event});

  @override
  _ProgramTranslationState createState() => _ProgramTranslationState();
}

class _ProgramTranslationState extends State<ProgramTranslation> {
  final translator = GoogleTranslator();
  String translatedProgram = '';

  @override
  void initState() {
    super.initState();
    translatedProgram = widget.event['Program'].toUpperCase();
  }

  void translateToHindi() async {
    var translation = await translator.translate(widget.event['Program'], to: 'hi');
    setState(() {
      translatedProgram = translation.text.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Translation'),
      ),
      body: SingleChildScrollView(  // Wrapping with SingleChildScrollView to avoid overflow
        child: Container(
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
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Program Name:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.language, color: Colors.green),
                      onPressed: translateToHindi, // Call translation function
                    ),
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.event, color: Colors.green),
                    hintText: translatedProgram,
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class ProgramTranslation extends StatefulWidget {
  final Map<String, dynamic> event;

  ProgramTranslation({required this.event});

  @override
  _ProgramTranslationState createState() => _ProgramTranslationState();
}

class _ProgramTranslationState extends State<ProgramTranslation> {
  final translator = GoogleTranslator();
  String programInEnglish = '';
  String translatedProgram = '';
  bool isEnglish = true; // Flag to toggle between English and Hindi

  @override
  void initState() {
    super.initState();
    // Initially set the program in English
    programInEnglish = widget.event['Program'].toUpperCase();
    translatedProgram = programInEnglish;
  }

  void toggleLanguage() async {
    if (isEnglish) {
      // Translate to Hindi
      var translation = await translator.translate(widget.event['Program'], to: 'hi');
      setState(() {
        translatedProgram = translation.text.toUpperCase();
        isEnglish = false; // Now showing in Hindi
      });
    } else {
      // Revert to English
      setState(() {
        translatedProgram = programInEnglish;
        isEnglish = true; // Now showing in English
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Translation'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Program Name:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.language, color: Colors.green),
                      onPressed: toggleLanguage, // Toggle between languages
                    ),
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.event, color: Colors.green),
                    hintText: translatedProgram, // Display the translated text
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}