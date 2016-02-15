/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das Schelling-Modell in Abschnitt 2.3
 */

import 'segregation.dart';
import 'dart:html';

NumberInputElement nieNumCellsX;
NumberInputElement nieNumCellsY;
NumberInputElement nieEmptyPercentage;
NumberInputElement nieSameNeighbors;
NumberInputElement nieCellWidth;
NumberInputElement nieCellHeight;
NumberInputElement nieCellBetween;
CheckboxInputElement nieRedDiamond;

class SegregationWeb extends Segregation {

  CanvasElement _canvas;
  ParamElement _pe;
  num _width;
  num _height;
  int widthOfCell;
  int heightOfCell;
  int betweenCells;
  bool redDiamond;

  SegregationWeb(this._canvas) : super() {
    var doc = window.document;
    _pe = doc.querySelector('#stepCounter');
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
        final Agent a = agent(i, j);
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

  final CanvasElement canvas = querySelector("#area");
  var s = new SegregationWeb(canvas);

  // Ermittle die HTML-Elemente
  var doc = window.document;
  nieNumCellsX = doc.querySelector('#numCellsX');
  nieNumCellsY = doc.querySelector('#numCellsY');
  nieEmptyPercentage = doc.querySelector('#emptyPercentage');
  nieSameNeighbors = doc.querySelector('#sameNeighbors');
  nieCellWidth = doc.querySelector('#cellWidth');
  nieCellHeight = doc.querySelector('#cellHeight');
  nieCellBetween = doc.querySelector('#cellBetween');
  nieRedDiamond = doc.querySelector('#redDiamond');

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
    s.redDiamond = nieRedDiamond.checked;
    s.requestRedraw();
  });

  // Wenn der "Step"-Button gedrückt wird, wird step() aufgerufen
  doc.querySelector("#stepButton").onClick.listen((_) {
    s.step();
    s.requestRedraw();
  });

  // Wenn der "Setup"-Button gedrückt wird, wird setup() mit den
  // aktuellen Parametern aufgerufen
  doc.querySelector("#setupButton").onClick.listen((_) {
    final int m = int.parse(nieNumCellsX.value);
    final int n = int.parse(nieNumCellsY.value);
    s.empty = double.parse(nieEmptyPercentage.value);
    s.numberOfSame = int.parse(nieSameNeighbors.value);
    s.widthOfCell = int.parse(nieCellWidth.value);
    s.heightOfCell = int.parse(nieCellHeight.value);
    s.betweenCells = int.parse(nieCellBetween.value);
    s.redDiamond = nieRedDiamond.checked;
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