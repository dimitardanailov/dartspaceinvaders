part of spaceinvaders;

class SpaceInvadersResourceManager extends ResourceManager {

  // Constructor
  SpaceInvadersResourceManager():super() {
    
  }
  
  // Add resource into Game Stage
  Future load() {
    // Add multiple resources
    this
     ..addBitmapData("background", "assets/background.jpg");
    
    return super.load();
  }
}