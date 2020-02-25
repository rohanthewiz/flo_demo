import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

void main() {
  YamlMap doc = loadYaml(
      """
type: container # There can be only one root node
child-align: center
background-color: "#ffeef0"
padding: 8
children:
  - text: "This is our page"
    font-size: 1.4
    font-weight: bold
    color: blue
  - type: image
    src: "https://www.ccswm.org/assets/img/IMG_0007.JPG.b9c099ce0f6d1493.JPG"
    align: right
  - text: "What a lovely image above!"
    type: text # you don't need to specify a type for text, but is not illegal :-)
    class: comment
  - type: ordered-list
    children:
      - type: li
        text: Option 1
      - type: li
        text: Option 2
  - type: row
    align: left
    xalign: start # top
    children:
      - text: "First"
      - text: "Last"
  - type: column
    align: top
    xalign: right
    children:
      - text: "First Row"
      - text: "Second Row"
  - type: table
    columns:
      - text: "Heading 1"
      - text: "Heading 2"
      - text: "Heading 3"
    rows:
      - type: row
        children:
          - text: "Cell 1"
          - text: "Cell 2"
      - type: row
        children:
          - text: "Cell 3"
          - text: "Cell 4"
""");

  doc.forEach((k,v) {
    if (k == 'children') {
      YamlList nodes = doc['children'];
//      nodes.forEach((child) {
//        child.forEach((k,v) => print('  $k -> $v'));
//      });
      //
    } else {
      print('$k -> $v');
    }
  });

  runApp(
      MaterialApp(
          title: 'CCSWM',
          theme: ThemeData(primarySwatch: Colors.cyan),
          home: Scaffold(
              appBar: AppBar(
                title: Text('Flo Demo'),
              ),
              body: Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                      children: buildWidgets(doc['children'])
                  )
              )
          )
      )
  );
}

List<Widget> buildWidgets(YamlList nodes) {
  List<Widget> w = List();

  nodes.forEach((child) {
    var type = "text"; // this is the default if no type specified
    var textVal = "";
    var color = 0xff101010;
    var fontWeight = FontWeight.normal;
    var src = "#";

    child.forEach((k, v) {
      if (k == 'children') {
        // Need to tie this back to the parent widget
        // Widget Row( children: buildWidgets(v))
      } else {
        print('  $k -> $v');
        if (k == "text") { // TODO - use a switch
          textVal = v;
        } else if (k == "color") {
          color = 0xff2440a0; // TODO: lookup v in a map
        } else if (k == 'font-weight') {
          fontWeight = FontWeight.bold; // TODO: lookup v in a map
        } else if (k == 'image') {
          type = 'image';
          src = v;
        }
      }
    });

    if (type == "text") {
      w.add(RichText(text:
      TextSpan(text: textVal,
          style: TextStyle(color: Color(color),
            fontWeight: fontWeight,
          ))));
    } else if (type == "image") {
      w.add(Image(image: NetworkImage(src), alignment: Alignment.centerRight));
    }
  });

//  doc.forEach((k,v) {
//    if (k == 'children') {
//      YamlList nodes = doc['children'];
////      nodes.forEach((child) {
////        child.forEach((k,v) => print('  $k -> $v'));
////      });
//      //
//    } else {
//      print('$k -> $v');
//    }
//  });

  w.add(Text("A Text Widget"));
  return w;
}
