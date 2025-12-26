/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das Schelling-Modell in Abschnitt 2.3
 */

import 'dart:html';
import 'package:complexity_perspective/simulations/segregation.dart';

late NumberInputElement nieNumCellsX;
late NumberInputElement nieNumCellsY;
late NumberInputElement nieEmptyPercentage;
late NumberInputElement nieSameNeighbors;
late NumberInputElement nieCellWidth;
late NumberInputElement nieCellHeight;
late NumberInputElement nieCellBetween;
late CheckboxInputElement nieRedDiamond;

class SegregationWeb extends Segregation {

  CanvasElement _canvas;
  late ParagraphElement _pe;
  num _width = 0;
  num _height = 0;
  int widthOfCell = 0;
  int heightOfCell = 0;
  int betweenCells = 0;
  bool redDiamond = false;

  SegregationWeb(this._canvas) : super() {
    var doc = window.document;
    final pe = doc.querySelector('#stepCounter') as ParagraphElement?;
    if (pe == null) {
      throw Exception("Element #stepCounter not found");
    }
    _pe = pe;
  }

  void setup(int m, int n) {
    super.setup(m, n);
    _canvas.width = _width = widthOfCell * m;
    _canvas.height = _height = heightOfCell * n;
  }

  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }

  void draw([_]) {

    _pe.text = "Step ${stats.time}, min. equal = $numberOfSame";

    var ctx = _canvas.context2D;
    ctx.clearRect(0, 0, _width, _height);

    final int w = widthOfCell - betweenCells;
    final int h = heightOfCell - betweenCells;

    for (var j = 0; j < n; j++) {
      for (var i = 0; i < m; i++) {
        final Agent? a = agent(i, j);
        if (a != null) {
          final int x = i * widthOfCell;
          final int y = j * heightOfCell;
          if (redDiamond) {
            if (a.color == Color.red) {
              final int w2 = (w / 2).toInt();
              final int h2 = (h / 2).toInt();
              ctx.fillStyle = "#AF0A14";
              ctx.beginPath();
              ctx.moveTo(x + w2, y);
              ctx.lineTo(x + w, y + h2);
              ctx.lineTo(x + w2, y + h);
              ctx.lineTo(x, y + h2);
              ctx.lineTo(x + w2, y);
              ctx.closePath();
              ctx.fill();
            } else {
              ctx.fillStyle = "#1E2D5B";
              ctx.fillRect(x+1, y+1, w-1, h-1);
            }
          } else {
            ctx.fillStyle = (a.color == Color.red) ? "#AF0A14" : "#1E2D5B";
            ctx.fillRect(x, y, w, h);
          }
        }
      }
    }
  }

}

main() {

  // Startwerte
  final int numCellsX = 20;
  final int numCellsY = 20;
  final double startEmpty = 0.05;
  final int startNumberOfSame = 3;
  final int elemWidth = 16;
  final int elemHeight = 16;
  final int elemOffset = 2;
  final bool redDiamond = true;

  final CanvasElement? canvasElement = querySelector("#area") as CanvasElement?;
  if (canvasElement == null) {
    throw Exception("Canvas element #area not found");
  }
  var s = new SegregationWeb(canvasElement);

  // Ermittle die HTML-Elemente
  var doc = window.document;
  final numCellsXElement = doc.querySelector('#numCellsX') as NumberInputElement?;
  final numCellsYElement = doc.querySelector('#numCellsY') as NumberInputElement?;
  final emptyPercentageElement = doc.querySelector('#emptyPercentage') as NumberInputElement?;
  final sameNeighborsElement = doc.querySelector('#sameNeighbors') as NumberInputElement?;
  final cellWidthElement = doc.querySelector('#cellWidth') as NumberInputElement?;
  final cellHeightElement = doc.querySelector('#cellHeight') as NumberInputElement?;
  final cellBetweenElement = doc.querySelector('#cellBetween') as NumberInputElement?;
  final redDiamondElement = doc.querySelector('#redDiamond') as CheckboxInputElement?;
  
  if (numCellsXElement == null || numCellsYElement == null || emptyPercentageElement == null ||
      sameNeighborsElement == null || cellWidthElement == null || cellHeightElement == null ||
      cellBetweenElement == null || redDiamondElement == null) {
    throw Exception("Required form elements not found");
  }
  
  nieNumCellsX = numCellsXElement;
  nieNumCellsY = numCellsYElement;
  nieEmptyPercentage = emptyPercentageElement;
  nieSameNeighbors = sameNeighborsElement;
  nieCellWidth = cellWidthElement;
  nieCellHeight = cellHeightElement;
  nieCellBetween = cellBetweenElement;
  nieRedDiamond = redDiamondElement;

  // Setze die Startwerte ein
  nieNumCellsX.value = numCellsX.toString();
  nieNumCellsY.value = numCellsY.toString();
  nieEmptyPercentage.value = startEmpty.toString();
  nieSameNeighbors.value = startNumberOfSame.toString();
  nieCellWidth.value = elemWidth.toString();
  nieCellHeight.value = elemHeight.toString();
  nieCellBetween.value = elemOffset.toString();
  nieRedDiamond.checked = redDiamond;

  nieRedDiamond.onChange.listen((_) {
    s.redDiamond = nieRedDiamond.checked ?? false;
    s.requestRedraw();
  });

  // Wenn der "Step"-Button gedrückt wird, wird step() aufgerufen
  doc.querySelector("#stepButton")?.onClick.listen((_) {
    s.step();
    s.requestRedraw();
  });

  // Wenn der "Setup"-Button gedrückt wird, wird setup() mit den
  // aktuellen Parametern aufgerufen
  doc.querySelector("#setupButton")?.onClick.listen((_) {
    final int m = int.parse(nieNumCellsX.value ?? "0");
    final int n = int.parse(nieNumCellsY.value ?? "0");
    s.empty = double.parse(nieEmptyPercentage.value ?? "0");
    s.numberOfSame = int.parse(nieSameNeighbors.value ?? "0");
    s.widthOfCell = int.parse(nieCellWidth.value ?? "0");
    s.heightOfCell = int.parse(nieCellHeight.value ?? "0");
    s.betweenCells = int.parse(nieCellBetween.value ?? "0");
    s.redDiamond = nieRedDiamond.checked ?? false;
    s.setup(m, n);
    s.requestRedraw();
  });

  // Den ersten Aufruf müssen wir selber machen
  s.empty = startEmpty;
  s.numberOfSame = startNumberOfSame;
  s.widthOfCell = elemWidth;
  s.heightOfCell = elemHeight;
  s.betweenCells = elemOffset;
  s.redDiamond = redDiamond;
  s.setup(numCellsX, numCellsY);
  s.requestRedraw();

}