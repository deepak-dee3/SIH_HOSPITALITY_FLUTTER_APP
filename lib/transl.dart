import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorApp extends StatefulWidget {
  @override
  State<TranslatorApp> createState() => _TranslatorAppState();
}

class _TranslatorAppState extends State<TranslatorApp> {
  var languages = ['Tamil','Hindi', 'English', 'Arabic','Marathi','Oriya','Malayalam','Konkani','Nepali','Gujarati'];
  var origin = 'From';
  var destination = 'To';
  var output = ' ';
  TextEditingController textController = TextEditingController();

  // Translation function using Google Translator API
  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    
    // Perform translation
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text;
    });

    // Error handling for language selection
    if (src == '--' || dest == '--') {
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  // Function to map language names to language codes
 String getLangCode(String language) {
  if (language == "English") {
    return 'en';
  } else if (language == "Hindi") {
    return 'hi';
  } else if (language == "Arabic") {
    return 'ar';
  } else if (language == "Marathi") {
    return 'mr';
  } else if (language == "Nepali") {
    return 'ne';
  } else if (language == "Gujarati") {
    return 'gu';
  } else if (language == "Oriya") {
    return 'or';
  } else if (language == "Tamil") {
    return 'ta';
  } else if (language == "Konkani") {
    return 'kok';
  } else if (language == "Malayalam") {
    return 'ml';
  }
  return '--'; // Default for unsupported languages
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),

            // Row to select source and target languages
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      origin = value!;
                    });
                  },
                  hint: Text(origin),
                ),
                SizedBox(width: 30),
                DropdownButton<String>(
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      destination = value!;
                    });
                  },
                  hint: Text(destination),
                ),
              ],
            ),

            SizedBox(height: 30),

            // TextFormField for user input
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                controller: textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text';
                  }
                  return null;
                },
              ),
            ),

            // Button to perform translation
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  translate(getLangCode(origin), getLangCode(destination), textController.text.toString());
                },
                child: Text('Translate'),
              ),
            ),

            SizedBox(height: 30),

            // Display the translated output
            Text(
              output,
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
