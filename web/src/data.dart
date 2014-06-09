part of spaceinvaders;

class SpaceInvadersResourceManager extends ResourceManager {

  // Constructor
  SpaceInvadersResourceManager():super() {
    
  }
  
  // Add resource into Game Stage
  Future load() {
    // Add multiple resources
    this
     ..addBitmapData("background", "assets/background.jpg")
     ..addBitmapData("spaceship", "assets/alienblaster.png")
     ..addBitmapData("asteroid", "assets/158ltd-asteroid.jpg")
     ..addBitmapData("explosion", "assets/explosion_sprite.png");
    
    return super.load();
  }
}