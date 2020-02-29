import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

void main() {
  YamlMap doc = loadYaml("""
#type: container # There can be only one root node
background-color: "#ffeef0"
padding: 10
children:
  - text: "What's up Doc?"
    font-size: 20
    font-weight: w900
    color: "#501010"
  - type: column
    align: top
    xalign: right
    children:
      - text: "First Row"
        font-style: italic
      - text: "Second Row"
        font-weight: w700
  - type: row
    align: spaceEvenly
    xalign: end
    children:
      - text: "First Cell"
        color: '#20ff10'
      - text: " Last Cell"
        color: '#2010ff'
      - text: " I am here "
      - type: container
        color: '#cca820'
        padding: 6
        child:
          - type: column
            align: end
            xalign: end
            children:
              - type: padding
                padding: 4
                child:
                  - text: "Cell1 of Column"
              - type: padding
                padding: 4
                child:
                  - text: "Cell2 of Column"
                    color: "#691010"
  - type: padding
    padding: 6
    child:
    - type: image
      src: "https://cdn.pixabay.com/photo/2016/03/09/15/27/cat-1246659_960_720.jpg"
      width: 280
      height: 320
      align: right
  - text: "What a lovely picture!"
    font-size: 16
    color: "#606062"
    type: text # you don't need to specify a type for text, but is not illegal :-)
    class: comment
  - type: padding
    padding: 7
    child:
    - text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore."
""");

  runApp(
      MaterialApp(
          title: 'Flo Demo',
          theme: ThemeData(primarySwatch: Colors.brown),
          home: Scaffold(
              appBar: AppBar(
                title: Text('Flo Demo'),
              ),
              body: Container(
                  padding: EdgeInsets.all(doc['padding']?.ceilToDouble() ?? 6),
                  color: Color(
                      intFromHexString(doc['background-color'].toString())),
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
    var type = "text"; // this is the default type
    var textVal = "";
    var color = 0xff101010;
    var bgColor = 0xffffffff;
    var fontWeight = FontWeight.normal;
    var fontStyle = FontStyle.normal;
    var fontSize = 14;
    int padding;
    int width, height;
    var src = "#";
    var align = MainAxisAlignment.start;
    var xAlign = CrossAxisAlignment.center;
    List<Widget> children;
    Widget child;

    node.forEach((k, v) {
      if (k == 'children') {
        children = buildWidgets(v);
      } else if (k == "child") {
        child =
            buildWidgets(v).first; // todo - verify .first is safe null/empty
      } else if (k == "text") {
          textVal = v;
      } else if (k == 'type') {
        type = v;
      } else if (k == "color") {
        color = intFromHexString(v);
      } else if (k == "background-color") {
        bgColor = intFromHexString(v);
      } else if (k == 'font-weight') {
        var fw = enumValueFromString(v, FontWeight.values);
        if (fw != null) {
          fontWeight = fw;
        }
      } else if (k == 'font-style') {
        var fs = enumValueFromString(v, FontStyle.values);
        if (fs != null) {
          fontStyle = fs;
        }
      } else if (k == 'font-size') {
        if (v > 0) {
          fontSize = v;
        }
      } else if (k == 'src') {
        src = v;
      } else if (k == 'padding') {
        padding = v;
      } else if (k == 'width') {
        width = v;
      } else if (k == 'height') {
        height = v;
      } else if (k == 'align') {
        var a = enumValueFromString(v, MainAxisAlignment.values);
        if (a != null) {
          align = a;
        }
      } else if (k == 'xalign') {
        var x = enumValueFromString(v, CrossAxisAlignment.values);
        if (x != null) {
          xAlign = x;
        }
      }
    });

    // Build

    if (type == "text") {
      w.add(RichText(text: TextSpan(text: textVal,
          style: TextStyle(color: Color(color), fontWeight: fontWeight,
              fontStyle: fontStyle, fontSize: fontSize.ceilToDouble()))));
    } else if (type == "image") {
      w.add(Image.network(
          src, width: width.ceilToDouble(), height: height.ceilToDouble()));
    } else if (type == 'padding') {
      w.add(Padding(
          padding: EdgeInsets.all(padding.ceilToDouble()), child: child));
    } else if (type == 'column') {
      w.add(Column(children: children,
          mainAxisAlignment: align,
          crossAxisAlignment: xAlign));
    } else if (type == 'row') {
      w.add(Row(children: children,
          mainAxisAlignment: align,
          crossAxisAlignment: xAlign));
    } else if (type == 'container') {
      w.add(Container(child: child, color: Color(color),
          padding: EdgeInsets.all(padding.ceilToDouble())));
    }
  });

  return w;
}

int intFromHexString(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  return int.parse(hex, radix: 16);
}

String enumValueToString(Object o) =>
    o
        .toString()
        .split('.')
        .last;

T enumValueFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == enumValueToString(v), orElse: () => null);

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
