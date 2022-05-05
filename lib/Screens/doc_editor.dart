import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as QL;
import '../Style/style.dart';

class DocEditorScreen extends StatefulWidget {
  const DocEditorScreen({Key? key}) : super(key: key);

  @override
  State<DocEditorScreen> createState() => _DocEditorScreenState();
}

class _DocEditorScreenState extends State<DocEditorScreen> {
  int color_id=Random().nextInt(Style.cardColor.length);

  String date=DateTime.now().toString();
  TextEditingController _titleController=TextEditingController();
  // TextEditingController _mainController=TextEditingController();
  QL.QuillController _mainController=QL.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Style.cardColor[color_id],
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("New Note",style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title'
              ),
              style: Style.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(date,style:Style.dateTitle),
            SizedBox(
              height: 28.0,
            ),
            Expanded(child: QL.QuillEditor.basic(controller: _mainController, readOnly: false)),
            QL.QuillToolbar.basic(controller: _mainController,iconTheme: QL.QuillIconTheme(
              iconSelectedFillColor: Colors.white,
            ),
              multiRowsDisplay: false,
              showAlignmentButtons: true,)
          ],
        ),
     ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.accentColor,
        onPressed: () async{
          var json = jsonEncode(_mainController.document.toDelta().toJson());
          FirebaseFirestore.instance.collection("notes").add({
            "doc_title": _titleController.text,
            "creation_date":date,
            "doc_content":json,
            "color_id": color_id,
            "doc_search":_mainController.document.toPlainText()
          }).then((value){
            print(value.id);
            Navigator.pop(context);
          }).catchError((error)=>print("Failed to save due to $error"));

        },
        child: Icon(Icons.save),
      ),
    );
  }
}
