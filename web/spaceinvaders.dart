library spaceinvaders;

import 'dart:async';
import 'dart:html';
import 'dart:math' as math;

import 'package:stagexl/stagexl.dart';

// Sub Modules
part 'src/data.dart';
part 'src/main.dart';

void main() {
  CanvasElement canvasSelector = querySelector('canvas');
  
  var game = new SpaceInvaders(canvasSelector, webGL: true);
}

/*
Future load() { 
}
*/


