# flo_demo

Flo is a document language for Flutter. It will offer most of the capabilities of Flutter including layout, color, and other styling. This is currently POC. Things *will* change.

![Flo_demo](pics/flo_demo.png?raw=true "Flo Demo Screenshot")

Produced by this bit of YAML:

```
#type: container # There can be only one root node
background-color: "#ffeef0"
padding: 10
children:
  - text: "What's up doc?"
    font-size: 20
    font-weight: w900
    color: "#702040"
  - type: column
    align: top
    xalign: right
    children:
      - text: "First Row"
        font-style: italic
      - text: "Second Row"
        font-style: bold
  - type: row
    align: left
    xalign: start # top
    children:
      - text: "First Cell"
      - text: "Last Cell"
  - type: padding
    padding: 6
    child:
    - type: image
      src: "https://cdn.pixabay.com/photo/2016/03/09/15/27/cat-1246659_960_720.jpg"
      width: 240
      height: 320
      align: right
  - text: "What a lovely picture!"
    type: text # you don't need to specify a type for text, but is not illegal :-)
    class: comment
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
