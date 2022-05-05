import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_doc/Style/style.dart';
import 'package:flutter_quill/flutter_quill.dart' as QL;
import 'search.dart';

class DocReaderScreen extends StatefulWidget {
  static const String id="doc_reader_Screen";
   DocReaderScreen(this.doc,{Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  State<DocReaderScreen> createState() => _DocReaderScreenState();
}

class _DocReaderScreenState extends State<DocReaderScreen> {

  @override
  Widget build(BuildContext context) {
    var myJSON = jsonDecode(widget.doc.get("doc_content"));
    QL.QuillController _controller = QL.QuillController(
        document: QL.Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));
    int color_id = widget.doc["color_id"];
    return Scaffold(
      backgroundColor: Style.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Style.cardColor[color_id],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["doc_title"],
              style: Style.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: Style.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            Expanded(
              child:
              QL.QuillEditor.basic(
                controller: _controller,
                readOnly: true
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Search(widget.doc)));
        },
        backgroundColor: Style.accentColor,
        label: Text("Search"),
        icon: Icon(Icons.search),
      ),
    );
  }
}
