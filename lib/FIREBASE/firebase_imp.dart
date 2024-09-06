import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

create(String hos_name,hos_email,head_hos,hos_type,hos_loc,hos_landmark,hos_ph1,hos_ph2) async{



  await FirebaseFirestore.instance.collection("HOSPITAL'S").doc(hos_name).set({'hospital_name':hos_name,'hospital_mail':hos_email,'head':head_hos,'type':hos_type,'location':hos_loc,'landmark':hos_landmark,'Phone1':hos_ph1,'Phone2':hos_ph2});

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


