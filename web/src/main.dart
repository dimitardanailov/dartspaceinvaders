part of spaceinvaders;

class Game implements Animatable {
  IrregularBitmap ship;
  IrregularBitmap asteroid;
  Stage stage;
  Explosion explosion;
  
  Game();
  
  bool advanceTime(num t) {
    if(ship.collides(asteroid)) {
      
      explosion.x = ship.x - ship.pivotX;
      explosion.y = ship.y - ship.pivotY;
      explosion.stage.juggler
        ..removeTweens(ship)
        ..removeTweens(asteroid);
      
      stage.removeChild(ship);
      explosion.start();
      
      return false;
    }
    
    return true;
  }
}

class SpaceInvaders {
  Stage stage;
  RenderLoop renderLoop;
  Juggler juggler;
  SpaceInvadersResourceManager resourceManager;

  // Bitmaps
  Bitmap background;
  Spaceship spaceship;
  Asteroid asteroid;

  // Keys Hash Map
  HashMap<int, bool> keysPressed = new HashMap.from({
    37: false, // left
    38: false, // top
    39: false, // right
    40: false // down
  });

  // webGL is optional name.
  SpaceInvaders(CanvasElement element, {bool webGL: true}) {
    stage = new Stage(element, webGL: webGL);
    renderLoop = new RenderLoop();
    juggler = renderLoop.juggler;
    resourceManager = new SpaceInvadersResourceManager();
    resourceManager.load().then(onLoad);
  }

  void onLoad(ResourceManager a) {

    var explosion = new Explosion()..images = a.getBitmapData('explosion');
    
    // Background
    background = new Bitmap(resourceManager.getBitmapData("background"));
    setCenterPivot(background);
    centerOnStage(background);
    stage.addChild(background);

    // Asteroid
    RotationDescriptor rotationDescriptor = new RotationDescriptor(speed: 0.6);
    asteroid = new Asteroid(resourceManager.getBitmapData("asteroid"), rotationDescriptor);
    setCenterPivot(asteroid);
    stage.addChild(asteroid);
    juggler.add(asteroid);

    // Spaceship
    spaceship = new Spaceship(resourceManager.getBitmapData("spaceship"));
    spaceship.keysPressed = keysPressed;
    setCenterPivot(spaceship);
    centerOnStage(spaceship);   
    stage.addChild(spaceship);
    juggler.add(spaceship);
    
    stage.addChild(explosion);
    
    asteroid.target = spaceship;

    juggler.add(new Game()
        ..ship = spaceship
        ..asteroid = asteroid
        ..explosion = explosion
        ..stage = stage);

    start();

    int animationDuration = 10; // 10 sec
    Tween animation = new Tween(background, animationDuration);
    animation.animate.x.by(-100);
    animation.delay = 2;

    var rotationRadians = math.PI / 2; // 90deg
    animation.animate.rotation.to(rotationRadians);

    juggler.add(animation);

    // Fix : https://github.com/bp74/StageXL/issues/53
    // commented by bp74
    stage.focus = stage;

    // Stage Keyboards Events
    var handler = new ArrowKeysHandler(stage);
    handler.onKeyPressed.listen((num radians) {
      print(handler.direction);
      spaceship.rotation = radians;
    });
    
    /*
    stage
        ..onKeyUp.listen((KeyboardEvent e) {
          spaceship.keysPressed[e.keyCode] = false;
        })
        ..onKeyDown.listen((KeyboardEvent e) {
          spaceship.keysPressed[e.keyCode] = true;
        }); */
  }

  void start() {
    renderLoop.addStage(stage);
  }

  void setCenterPivot(Bitmap bitmap) {
    bitmap.pivotY = bitmap.height ~/ 2;
    bitmap.pivotX = bitmap.width ~/ 2;

    bitmap.y += bitmap.pivotY;
    bitmap.x += bitmap.pivotX;
  }

  void centerOnStage(Bitmap bitmap) {
    Point centerStage = findStageCenter();
    Point centerObject = findBitmapCenter(bitmap);

    bitmap.y = (centerStage.y - centerObject.y) + bitmap.pivotY;
    bitmap.x = (centerStage.x - centerObject.x) + bitmap.pivotX;
  }

  Point findStageCenter() {
    Point center = stage.contentRectangle.center;

    return center;
  }

  Point findBitmapCenter(Bitmap bitmap) {
    Point centerObject = new Point(0, 0);
    centerObject.y = bitmap.height / 2;
    centerObject.x = bitmap.width / 2;

    return centerObject;
  }

  /*** Key events ***/
  void spaceShipKeyDown(KeyboardEvent e) {
    num spaceShipRotation = spaceship.rotation;

    // Documentation: http://www.stagexl.org/docs/transitions.html
    var tween = new Tween(spaceship, 0.0, TransitionFunction.linear);

    spaceship.keysPressed[e.keyCode] = true;

    /*
    switch (e.keyCode) {

      // Left
      case 37:
        // 90deg
        tween.animate.rotation.to(math.PI / 2);
        break;

      // Up
      case 38:
        //180deg
        tween.animate.rotation.to(math.PI);
        break;

      // Right
      case 39:
        // 270deg
        tween.animate.rotation.to(math.PI * 1.5);
        break;

      // Down
      case 40:
        tween.animate.rotation.to(0);
        break;
    } */

    print(spaceship.keysPressed);

    juggler.add(tween);
  }
}
