// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeRepo{
//    Future <void> createtask(
//     String task, 
//     String description,     
//     BuildContext context
//    )

//    async {
//       final _auth = FirebaseAuth.instance;
//       final CollectionReference userRef = FirebaseFirestore.instance.collection('taskcollection');
   

//   try {
//     await userRef.doc().set(
//       {
//         'userid' : _auth.currentUser!.uid,
//         'task' : task,
//         'description' : description,
//       }
//     );

//   }on FirebaseAuthException catch (e) {
//     throw Exception('adding task failed');
//     print('error');
//   } 
    
// }
// }