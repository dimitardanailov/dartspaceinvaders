part of spaceinvaders;

class Explosion extends Bitmap implements Animatable {
  SpriteSheet spriteSheet;
  int frameCounter = 0;
  int skipFrames = 0;

  Explosion(): super();
  
  set images(BitmapData d) {
    spriteSheet = new SpriteSheet(d, 480~/5, 384~/4);
    bitmapData = spriteSheet.frames.last;
  }
  
  
  void start() {
    frameCounter = 0;
    stage.juggler.add(this);
  }

  @override
  bool advanceTime(num time) {
    skipFrames++;
    if (skipFrames >= 5) {
      skipFrames = 0;
      bitmapData = spriteSheet.frameAt(frameCounter);
      frameCounter++;

      if (frameCounter >= spriteSheet.frames.length) {
        return false;
      }
    }


    return true;
  }
}
