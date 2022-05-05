import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_doc/Screens/doc_editor.dart';
import 'package:google_doc/Screens/doc_reader.dart';
import 'package:google_doc/Style/style.dart';
import 'package:google_doc/Widgets/doc_card.dart';
import 'package:google_fonts/google_fonts.dart';

class DocPage extends StatefulWidget {
  static const String id = "Doc_Page_Screen";
  const DocPage({Key? key}) : super(key: key);

  @override
  State<DocPage> createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.mainColor,
      appBar: AppBar(
        title: Text("NOTES"),
        centerTitle: true,
        backgroundColor: Style.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent notes",
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    // final doc=snapshot.data?.docs;
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((doc) => docCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DocReaderScreen(doc),
                                    ));
                              }, doc))
                          .toList(),
                    );
                  }
                  else {
                    return Text(
                      "No Note Available",
                      style: GoogleFonts.nunito(color: Colors.white),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DocEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
