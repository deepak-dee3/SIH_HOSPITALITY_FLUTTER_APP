import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class EventDetailPagesTranslate extends StatefulWidget {
  final Map<String, dynamic> event;

  EventDetailPagesTranslate({required this.event});

  @override
  _EventDetailPagesTranslateState createState() => _EventDetailPagesTranslateState();
}

class _EventDetailPagesTranslateState extends State<EventDetailPagesTranslate> {
  final translator = GoogleTranslator();

  bool isEnglish = true;
  String originalProgram = '';
  String originalHospitalName = '';
  String originalLocation = '';
  String originalDateOfEvent = '';
  String originalAvailability = '';

  String translatedProgram = '';
  String translatedHospitalName = '';
  String translatedLocation = '';
  String translatedDateOfEvent = '';
  String translatedAvailability = '';

  @override
  void initState() {
    super.initState();
    // Initialize fields with original data
    originalProgram = widget.event['Program'];
    originalHospitalName = widget.event['Hospital_name'];
    originalLocation = widget.event['Location'];
    originalDateOfEvent = widget.event['Date Of Event'];
    originalAvailability = widget.event['Availability'];
    
    // Set translated fields to initial values
    translatedProgram = originalProgram;
    translatedHospitalName = originalHospitalName;
    translatedLocation = originalLocation;
    translatedDateOfEvent = originalDateOfEvent;
    translatedAvailability = originalAvailability;
  }

  void translateFields(String targetLang) async {
    final programTranslation = await translator.translate(originalProgram, to: targetLang);
    final hospitalTranslation = await translator.translate(originalHospitalName, to: targetLang);
    final locationTranslation = await translator.translate(originalLocation, to: targetLang);
    final dateOfEventTranslation = await translator.translate(originalDateOfEvent, to: targetLang);
    final availabilityTranslation = await translator.translate(originalAvailability, to: targetLang);

    setState(() {
      translatedProgram = programTranslation.text;
      translatedHospitalName = hospitalTranslation.text;
      translatedLocation = locationTranslation.text;
      translatedDateOfEvent = dateOfEventTranslation.text;
      translatedAvailability = availabilityTranslation.text;
    });
  }

  void toggleLanguage() {
    if (isEnglish) {
      translateFields('hi');
    } else {
      // Set back to original English values
      setState(() {
        translatedProgram = originalProgram;
        translatedHospitalName = originalHospitalName;
        translatedLocation = originalLocation;
        translatedDateOfEvent = originalDateOfEvent;
        translatedAvailability = originalAvailability;
      });
    }
    setState(() {
      isEnglish = !isEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event Details'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.js_m--7-FZoWCNrtRA-kQwHaFj?w=205&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06),

              // Program Name
              Text(
                'Program Name:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                translatedProgram,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Hospital Name
              Text(
                'Hospital Name:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                translatedHospitalName,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Location
              Text(
                'Location:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                translatedLocation,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Date Of Event
              Text(
                'Date Of Event:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                translatedDateOfEvent,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Availability
              Text(
                'Availability:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                translatedAvailability,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
