import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart' as QL;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_doc/Widgets/KMP_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../Style/style.dart';

class Search extends StatefulWidget {
   Search(this.doc,{Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchController =TextEditingController();
  bool found=false;
  String Pattern="";
  @override
  Widget build(BuildContext context) {

    int color_id = widget.doc["color_id"];

    String text=widget.doc["doc_search"];
    Widget TextHighlight=found?SubstringHighlight(
        caseSensitive: true,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        text: text,
        term: Pattern,
        textAlign: TextAlign.right,
        textStyleHighlight: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal,color: Colors.amber),
        textStyle: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal,color: Colors.black),
        words: false):Text(
      widget.doc["doc_search"],
      style: Style.mainContent,
      overflow: TextOverflow.ellipsis,
    );
    return Scaffold(
        backgroundColor: Style.cardColor[color_id],
        appBar: AppBar(
        backgroundColor: Style.cardColor[color_id],
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    )
                ),
              ),
              TextButton(onPressed: (){
                List pos=[];
                if(_searchController!="") {
                  List<int> positions = kmpSearch(
                      _searchController.text, text);
                  pos=positions;
                }
                setState(() {
                  if(_searchController.text=="")
                    {
                      found=false;
                    }
                  else {
                    if (!pos.isEmpty) {
                      Pattern = _searchController.text;
                      found = true;
                    }
                    else {
                      Pattern = _searchController.text;
                      found = false;
                    }
                  }
                });
              }, child: Icon(Icons.search, size: 40.0,)
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          TextHighlight


        ],
      ),
    );
  }

}
