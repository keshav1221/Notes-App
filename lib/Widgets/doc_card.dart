import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart' as QL;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_doc/Style/style.dart';

import '../Screens/doc_reader.dart';

Widget docCard( Function()? onTap,DocumentSnapshot doc)
{
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Style.cardColor[doc.get('color_id')],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc.get("doc_title"),
            style: Style.mainTitle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            doc.get("creation_date"),
            style: Style.dateTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: Text(
              doc.get("doc_search"),
              style: Style.mainContent,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
  );
}