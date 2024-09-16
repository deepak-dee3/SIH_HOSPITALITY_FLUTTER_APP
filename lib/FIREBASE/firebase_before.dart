import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

create(String b_hos_name,b_program_name,b_place,b_date,b_availability,b_sd,b_d,b_su,b_m,b_sp,b_s_a) async{



  await FirebaseFirestore.instance.collection('BEFORE EVENT').doc(b_program_name).set({
    'Hospital_name':b_hos_name,'Program':b_program_name,'Location':b_place,'Date Of Event':b_date,'Availability':b_availability,
    'Sub_District':b_sd,'District':b_d,'State / Union Territory':b_su,'Mode_of_program':b_m,'Sponser':b_sp,'Sponser_amount':b_s_a
    });

  print('Hospital is data created');

}

update(String collname,docname,field,var newfield) async{

  await FirebaseFirestore.instance.collection(collname).doc(docname).update({field:newfield});

  print('data updated');

}

delete(String collname,docname) async {

  await FirebaseFirestore.instance.collection(collname).doc(docname).delete();

  print('document deleted');
}



/*void saveEvent(String b_hos_name,b_program_name,b_place,b_date,b_availability) async {
  // Reference to Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Document for the hospital
  DocumentReference hospitalRef = firestore.collection('HOSPITAL_PROGRAMS').doc(b_hos_name);

  // Nested document for the event within the hospital document
  DocumentReference eventRef = hospitalRef.collection('Before Event').doc(b_program_name);

  // Set event document with a field
  await eventRef.set({
   'Hospital_name':b_hos_name,
   'Program':b_program_name,
   'Location':b_place,
   'Date Of Event':b_date,
   'Availability':b_availability
  });

  // Optional confirmation
  print('Event details saved under "hospital_name" with event name "event_name".');
}*/



