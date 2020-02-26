import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

void main() {
  YamlMap doc = loadYaml("""
type: container # There can be only one root node
child-align: center
background-color: "#ffeef0"
padding: 8
children:
  - text: "This is our page"
    font-size: 1.4
    font-weight: bold
    color: "#702040"
  - type: column
    align: top
    xalign: right
    children:
      - text: "First Row"
      - text: "Second Row"
  - type: row
    align: left
    xalign: start # top
    children:
      - text: "First Cell  "
      - text: "Last Cell"
  - type: padding
    padding: 6
    child:
    - type: image
      src: "https://cdn.pixabay.com/photo/2016/03/09/15/27/cat-1246659_960_720.jpg"
      width: 240
      height: 320
      align: right
  - text: "What a lovely image above!"
    type: text # you don't need to specify a type for text, but is not illegal :-)
    class: comment
""");

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

  nodes.forEach((node) {
    var type = "text"; // this is the default if no type specified
    var textVal = "";
    var color = 0xff101010;
    var fontWeight = FontWeight.normal;
    int padding;
    int width, height;
    var src = "#";
    String xAlign;
    List<Widget> children;
    Widget child;

    node.forEach((k, v) {
      if (k == 'children') {
        children = buildWidgets(v);
      } else if (k == "child") {
        child = buildWidgets(v)
            .first; // todo - verify .first is safe on null or empty
      } else if (k == "text") {
          textVal = v;
      } else if (k == 'type') {
        type = v;
      } else if (k == "color") {
        color = intFromHexString(v);
      } else if (k == 'font-weight') {
        fontWeight = FontWeight.bold; // TODO: lookup v in a map
      } else if (k == 'src') {
        src = v;
      } else if (k == 'padding') {
        padding = v;
      } else if (k == 'width') {
        width = v;
      } else if (k == 'height') {
        height = v;
      }
    });

    // Build

    if (type == "text") {
      w.add(RichText(text: TextSpan(text: textVal,
          style: TextStyle(color: Color(color), fontWeight: fontWeight))));
    } else if (type == "image") {
      w.add(Image.network(src, width: null, height: height.ceilToDouble()));
    } else if (type == 'padding') {
      w.add(Padding(
          padding: EdgeInsets.all(padding.ceilToDouble()), child: child));
    } else if (type == 'column') {
      w.add(Column(children: children));
    } else if (type == 'row') {
      w.add(Row(children: children));
    }
  });

  return w;
}

int intFromHexString(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  return int.parse(hex, radix: 16);
}

// SCRAPS

//- type: ordered-list
//children:
//- type: li
//text: Option 1
//- type: li
//text: Option 2
//- type: table
//column:
//- text: "Heading 1"
//- text: "Heading 2"
//- text: "Heading 3"
//rows:
//- type: row
//children:
//- text: "Cell 1"
//- text: "Cell 2"
//- type: row
//children:
//- text: "Cell 3"
//- text: "Cell 4"

//  doc.forEach((k,v) {
//    if (k == 'children') {
//      YamlList nodes = doc['children'];
//      nodes.forEach((child) {
//        child.forEach((k,v) => print('  $k -> $v'));
//      });
//      //
//    } else {
//      print('$k -> $v');
//    }
//  });
