/**
 *
 */

import 'segregation.dart';
import 'dart:html';

class SegregationWeb extends Segregation {

  CanvasElement canvas;
  num width;
  num height;
  var doc;

  int elemWidth;
  int elemHeight;
  int elemOffset;

  NumberInputElement emptyPercentage;
  NumberInputElement sameNeighbors;
  NumberInputElement cellWidth;
  NumberInputElement cellHeight;
  NumberInputElement cellBetween;

  ParamElement pe;

  SegregationWeb(int m, int n, this.canvas, this.elemWidth, this.elemHeight, this.elemOffset) : super(m, n) {

    Rectangle rect = canvas.parent.client;

    width = elemWidth * m;
    height = elemHeight * n;
    canvas.width = width;
    canvas.height = height;

    doc = window.document;

    pe = doc.querySelector('#stepCounter');

    doc.querySelector("#step").onClick.listen((_) {
      step();
      requestRedraw();
    });
    doc.querySelector("#setup").onClick.listen((_) {
      setup();
      requestRedraw();
    });

    var errorMsg = doc.querySelector("#error_msg");

    emptyPercentage = doc.querySelector('#emptyPercentage');
    emptyPercentage.onChange.listen((_) {
      print("HUHU");
    });
    //emptyPercentage.valueAsNumber = empty;

    sameNeighbors = doc.querySelector('#sameNeighbors');
    sameNeighbors.onChange.listen((_) {
      print("HUHU");
    });
    //sameNeighbors.valueAsNumber = numberOfSame;

    cellWidth = doc.querySelector('#cellWidth');
    cellWidth.onChange.listen((_) {
      emptyPercentage.valueAsNumber = 2030;
      print("HUHU");
    });

    cellHeight = doc.querySelector('#cellHeight');
    cellHeight.onChange.listen((_) {
      elemHeight = 2;
      requestRedraw();
    });

    cellBetween = doc.querySelector('#cellBetween');
    cellBetween.onChange.listen((_) {
      emptyPercentage.value = "drawX";
      try {
        emptyPercentage.value = "huhu: ${cellBetween.value}:";
        int i = cellBetween.valueAsNumber;
        elemOffset = i;
        requestRedraw();
      } finally {

      }
    });

  }

  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }

  void draw([_]) {

    pe.text = "Step ${stats.time}, min. equal = $numberOfSame";

    var ctx = canvas.context2D;
    ctx.clearRect(0, 0, width, height);

    final int w = elemWidth - elemOffset;
    final int h = elemHeight - elemOffset;

    for (var j = 0; j < n; j++) {
      for (var i = 0; i < m; i++) {
        Agent a = cells.get(i, j);
        if (a != null) {
          final int x = i * elemWidth;
          final int y = j * elemHeight;
          ctx.fillStyle = (a.color == Color.red) ? "#AF0A14" : "#1E2D5B";
          ctx.fillRect(x, y, w, h);
        }
      }
    }
  }

}

main() {

  /*
    final int maxT = 100;
  final int size = 50;
  final double empty = 0.01;
  final int numberOfSame = 3;
  final int elemWidth = 8;
  final int elemHeight = 8;
  final int elemOffset = 0;


  // for book, image 1
  final int maxT = 100;
  final int size = 20;
  final double empty = 0.05;
  final int numberOfSame = 3;
  final int elemWidth = 16;
  final int elemHeight = 16;
  final int elemOffset = 2;

  // for book, image 2
  final int maxT = 100;
  final int size = 20;
  final double empty = 0.05;
  final int numberOfSame = 3;
  final int elemWidth = 16;
  final int elemHeight = 16;
  final int elemOffset = 2;
   */

  //elemWidth * size + 2 * elemOffset

  final int maxT = 1000;
  final int size = 500;
  final double empty = 0.01;
  final int numberOfSame = 4;
  final int elemWidth = 1;
  final int elemHeight = 1;
  final int elemOffset = 0;

  CanvasElement canvas = querySelector("#area");
  var s = new SegregationWeb(size, size, canvas, elemWidth, elemHeight, elemOffset);
  s.empty = empty;
  s.numberOfSame = numberOfSame;
  s.setup();
  s.requestRedraw();

}