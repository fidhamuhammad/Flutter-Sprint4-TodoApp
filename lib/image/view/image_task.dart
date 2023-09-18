import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/image/repository/image_repo.dart';
import 'package:todoapp/image/view/card.dart';
import 'package:todoapp/image/view/viewimage_task.dart';

class ImageTask extends StatefulWidget {
  const ImageTask({Key? key}) : super(key: key);

  @override
  _ImageTaskState createState() => _ImageTaskState();
}

class _ImageTaskState extends State<ImageTask> {
  final TextEditingController _tasknameController = TextEditingController();
  final TextEditingController _taskdescriptionController = TextEditingController();
  final TextEditingController _taskdurationController = TextEditingController();
  List<XFile> imageList = [];
  Future<dynamic> getImage() async {
    final imagePicker = ImagePicker();
    imageList = await imagePicker.pickMultiImage();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tasknameController.dispose();
    _taskdescriptionController.dispose();
    _taskdurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 135, 244),
        title: Center(
          child: Text(
            "Image Tasks",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _tasknameController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 146, 135, 244)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Task',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _taskdescriptionController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 146, 135, 244)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task description';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _taskdurationController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 146, 135, 244)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Duration',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task duration';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 146, 135, 244),
                ),
              ),
              onPressed: () {
                getImage();
              },
              child: Text(
                'Upload Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 146, 135, 244),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ImageTaskRepo().createImageTask(
                    _tasknameController.text,
                    _taskdescriptionController.text,
                    _taskdurationController.text,
                    imageList!,
                    context,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Image task added')),
                  );
                }
              },
              child: Text(
                'Add Image Task',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 146, 135, 244),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewImageTask(),
                    ));
              },
              child: Text(
                'view image task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:todoapp/image/repository/image_repo.dart';

// class ImageTask extends StatelessWidget {
//   ImageTask({super.key});

//   final TextEditingController _tasknameController = TextEditingController();
//   final TextEditingController _taskdescriptionController = TextEditingController();
//   final TextEditingController _taskdurationController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 189, 182, 250),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 146, 135, 244),
//         title: Center(
//           child: Text(
//             "Image Tasks",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
//           ),
//         ),
//       ),
//       body: Form(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               controller: _tasknameController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: 'Task'),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               controller: _taskdescriptionController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: 'description'),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               controller: _taskdurationController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: 'duration'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(
//                     Color.fromARGB(255, 146, 135, 244)),
//               ),
//               onPressed: () {},
//               child: Text(
//                 'upload image',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(
//                     Color.fromARGB(255, 146, 135, 244)),
//               ),
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   await ImageTaskRepo().createImageTask(
//                       _tasknameController.text,
//                       _taskdescriptionController.text,
//                       _taskdurationController.text,
//                       context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('image task added')));
//                 }
//               },
//               child: Text(
//                 'Add image tasks',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
