part of spaceinvaders;

class SpaceInvaders {
  
  Stage stage;
  RenderLoop renderLoop;
  Juggler juggler;
  SpaceInvadersResourceManager resourceManager;
  
  // Bitmaps
  Bitmap background;
  
  // webGL is optional name.
  SpaceInvaders(CanvasElement element, { bool webGL : true }) {
    stage = new Stage(element, webGL: webGL); 
    renderLoop = new RenderLoop();
    juggler = renderLoop.juggler;
    resourceManager = new SpaceInvadersResourceManager();
    resourceManager.load().then(onLoad);    
  }
  
  void onLoad(dynamic a) {
    background = new Bitmap(resourceManager.getBitmapData("background"));
    
    setCenterPivot(background);
    centerOnStage(background);
    
    stage.addChild(background);
    
    start();
    
    int animationDuration = 10; // 10 sec
    Tween animation = new Tween(background, animationDuration);
    animation.animate.x.by(-100);
    animation.delay = 2;
    
    var rotationRadians = math.PI / 2; // 90deg
    animation.animate.rotation.to(rotationRadians);
    
    juggler.add(animation);
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
}