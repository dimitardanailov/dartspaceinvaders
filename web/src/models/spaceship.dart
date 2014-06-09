part of spaceinvaders;

class Spaceship extends IrregularBitmap implements Animatable {

  int speed = 1;
  num step = 1.0; // Pixels

  HashMap<int, bool> keysPressed = new HashMap();
  
  // List of poligon points
  static List<Point<int>> spaceshipPoints = [
    new Point(128, 64),
    new Point(20, 98),
    new Point(20, 30),
  ];

  // List with all valid game combinations
  static Map<String, List<int>> combinations = new Map.from({
    'topright': [38, 39],
    'topleft': [37, 38],
    'downright': [39, 40],
    'downleft': [37, 40],
    'top': [38],
    'right': [39],
    'bottom': [40],
    'left': [37]
  });

  static List<String> rotations = 
      ['topright', 'topleft', 'downright', 'downleft', 'top', 'right', 'bottom', 'left'];

  // Bitmap - object
  // BitmapData - only pixels
  Spaceship(BitmapData bitmapSpace) : super() {
    bitmapData = bitmapSpace;
    
    setPolygonPoints(spaceshipPoints);
  }

  @override
  bool advanceTime(num time) {

    //    num transformedRotation = rotation + math.PI / 2;

    // Source:
    // http://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circles-circumference
    // http://en.wikipedia.org/wiki/Circle#Equations
    x = x + (step * speed) * math.cos(rotation);
    y = y + (step * speed) * math.sin(rotation);

    /*
    String spaceRotation = null;
    for (var combination in rotations) {
      var keys = combinations[combination];
      // How many elements in this combanation
      int keysSize = keys.length;
      int _keysPressed = 0;

      keys.forEach((key) {
        if (keysPressed[key]) {
          _keysPressed++;
        }
      });

      if (keysSize == _keysPressed && spaceRotation == null) {
        spaceRotation = combination;
        break;
      }
    }

    print(spaceRotation);
    */
    
    return true;
  }
}
