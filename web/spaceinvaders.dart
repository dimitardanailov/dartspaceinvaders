library spaceinvaders;

import 'dart:async';
import 'dart:collection';
import 'dart:html' hide Point, KeyboardEvent;
import 'dart:math' as math;

// Peter Janakiev Library
import 'package:convenience_xl/convenience_xl.dart';

import 'package:stagexl/stagexl.dart';

// Sub Modules
part 'src/data.dart';
part 'src/main.dart';
part 'src/models/spaceship.dart';
part 'src/models/asteroid.dart';
part 'src/models/explosion.dart';

void main() {
  CanvasElement canvasSelector = querySelector('canvas');
  
  var game = new SpaceInvaders(canvasSelector, webGL: true);
}

/*
Future load() { 
}
*/


