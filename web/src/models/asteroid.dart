part of spaceinvaders;

class Asteroid extends IrregularBitmap implements Animatable {
  
  RotationDescriptor asteroid;
  
  // Resource: http://www.mathopenref.com/ellipse.html
  int horizontalSemiAxis = 500;
  int verticalSemiAxis = 400;
  num radians = math.PI * (3 / 4);
  
  // List of poligon points
  static List<Point<int>> asteroidPoints = [
    new Point(0, 0),
    new Point(55, 0),
    new Point(55, 55),
    new Point(0, 55)
  ];
  
  IrregularBitmap target;
  
  Asteroid(BitmapData data, this.asteroid)  : super() {
    bitmapData = data;
    
    setPolygonPoints(asteroidPoints);
  }
  
  @override
  bool advanceTime(num time) {
    asteroid.delta = time;
    rotation = rotation + asteroid.radians;
    
    x = (horizontalSemiAxis / 2) * (math.cos(radians));
    y = (verticalSemiAxis / 2) * (math.sin(radians));
    
    radians = radians + (math.PI / 180);
    
    if (collides(target)) {
      
    }
    
    return true;
  }
}