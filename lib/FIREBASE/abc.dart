import 'package:cloud_firestore/cloud_firestore.dart';

void saveEvent() async {
  // Reference to Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Document for the hospital
  DocumentReference hospitalRef = firestore.collection('HOSPITAL_PROGRAMS').doc('hospital_name');

  // Nested document for the event within the hospital document
  DocumentReference eventRef = hospitalRef.collection('event').doc('event_name');

  // Set event document with a field
  await eventRef.set({
    'event_details': '2024-09-10', // Example value
  });

  // Optional confirmation
  print('Event details saved under "hospital_name" with event name "event_name".');
}
