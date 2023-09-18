import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/image/view/image_task.dart';
import 'package:todoapp/login/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final TextEditingController _tasknameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference _todoRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoRef = _firestore.collection('todo task');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageTask(),
                  ));
            },
            icon: Icon(Icons.image_rounded),
          ),
          IconButton(
              onPressed: () async {
                await _auth.signOut().then((value) {
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                });
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Color.fromARGB(255, 146, 135, 244),
        title: Center(
          child: Text(
            "Welcome to home page",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _tasknameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please fill this filed';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Task name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please fill this filed';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Description'),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 146, 135, 244)),
              ),
              onPressed: () async {
                await _todoRef.add({
                  'task': _tasknameController.text,
                  'description': _descriptionController.text,
                  'userid': _auth.currentUser!.uid,
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('task added')));
                _tasknameController.clear();
                _descriptionController.clear();
              },
              child: Text(
                'add task',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _todoRef
                    .where(
                      'userid',
                      isEqualTo: _auth.currentUser?.uid,
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final singledocument = documents[index];
                      return ListTile(
                        title: Text(singledocument['task'] as String),
                        subtitle: Text(singledocument['description'] as String),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Color.fromARGB(255, 125, 115, 216)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final doc = documents[index];
                                    _tasknameController.text =
                                        doc['task'] as String;
                                    _descriptionController.text =
                                        doc['description'] as String;
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(255, 189, 182, 250),
                                      title: Text(
                                        'Edit task',
                                      ),
                                      content: Column(
                                        children: [
                                          TextField(
                                            controller: _tasknameController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                hintText: 'task'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            controller: _descriptionController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                hintText: 'description'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Color.fromARGB(255,
                                                              146, 135, 244)),
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('todo task')
                                                      .doc(singledocument.id)
                                                      .update({
                                                    'task': _tasknameController
                                                        .text,
                                                    'description':
                                                        _descriptionController
                                                            .text,
                                                  });
                                                  _tasknameController.clear();
                                                  _descriptionController
                                                      .clear();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'updated successfully'),
                                                  ));
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Color.fromARGB(255,
                                                              146, 135, 244)),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 125, 115, 216),
                              ),
                              onPressed: () {
                                final todo = _todoRef.doc(singledocument.id);
                                todo.delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'this task has been deleted')));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
