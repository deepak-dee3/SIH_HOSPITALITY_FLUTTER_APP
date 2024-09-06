import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

create_after(String a_hos_name,a_program_name,a_place,a_date,a_type, String after_no_parti, String after_hours, String after_feedback) async{



  await FirebaseFirestore.instance.collection('AFTER EVENT').doc(a_program_name).set({
    'Hospital_name':a_hos_name,'Program':a_program_name,'Location':a_place,'Date Of Event':a_date,'Type':a_type,
    'Participants':after_no_parti,'Hours Taken':after_hours,'Feedback':after_feedback
    });

  print('Hospital after  data created');

}

update(String collname,docname,field,var newfield) async{

  await FirebaseFirestore.instance.collection(collname).doc(docname).update({field:newfield});

  print('data updated');

}

delete(String collname,docname) async {

  await FirebaseFirestore.instance.collection(collname).doc(docname).delete();

  print('document deleted');
}
