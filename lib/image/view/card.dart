import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {
  const CardWidgets({Key? key, required this.imageTask}):super(key: key);
  final QueryDocumentSnapshot <Map<String,dynamic>> imageTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      body: 
      Container(
        height: 200,
        width: 200,
        child: Card(       
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child:
             Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Image.network(imageTask['taskimage'][0].toString(),height: 80,width: 80,),
                 Text(imageTask['name'].toString()),
                 Text(imageTask['description'].toString()),
                 Text(imageTask['duration'].toString()),

               ],
             ),
        ),
      ),
    );
       
  }
}
