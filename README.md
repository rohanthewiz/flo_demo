# flo_demo

Flo is a document language for Flutter. It will offer most of the capabilities of Flutter including layout, color, and other styling. This is currently POC. Things *will* change.

![Flo_demo](pics/flo_demo.png?raw=true "Flo Demo Screenshot")

Produced by this bit of YAML:

```yaml
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
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
