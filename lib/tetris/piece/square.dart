import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';

class Square extends PositionComponent{

  BlockColor color;
  Square(this.color){
    size = BLOCK_RECT.toVector2();
  }
  Vector2 getLogicalPosition(){
    return Vector2(1, 1);
  }

  @override
  void render(Canvas canvas){
    final paint = switch(this.color){
      BlockColor.Cyan => CYAN_PAINT,
      
      BlockColor.Blue => BLUE_PAINT,
      
      BlockColor.Orange => ORANGE_PAINT,
      
      BlockColor.Yellow => YELLOW_PAINT,
      
      BlockColor.Green => GREEN_PAINT,
      
      BlockColor.Purple => PURPLE_PAINT,
      
      BlockColor.Red => RED_PAINT,
    };
    canvas.drawRect(BLOCK_RECT, paint);
  }

  
  bool collidesWith(Vector2 other){
    Vector2 otherPosition = other;
    Vector2 myPosition = position;
    Vector2 otherSize = BLOCK_RECT.toVector2();
    Vector2 mySize = size;

    Vector2 myCenter = (myPosition + mySize)/2;
    Vector2 otherCenter = (otherPosition + otherSize)/2;
    
    Vector2 diffCenter = myCenter - otherCenter;

    return 
         diffCenter.x.abs() < COLLISTION_TOLERANCE 
      && diffCenter.y.abs() < COLLISTION_TOLERANCE;
  }

  bool touchesBlock(Vector2 other){
    Vector2 otherPosition = other;
    Vector2 myPosition = position;
    Vector2 otherSize = BLOCK_RECT.toVector2();
    Vector2 mySize = BLOCK_RECT.toVector2();

    Vector2 myCenter = (myPosition + mySize)/2;
    Vector2 otherCenter = (otherPosition + otherSize)/2;
    
    return ((myCenter.x - otherCenter.x).abs() < COLLISTION_TOLERANCE) && 
            (myCenter.y - otherCenter.y).abs() < BLOCK_RECT.toVector2().y - COLLISTION_TOLERANCE &&
            (myCenter.y < otherCenter.y);
  }

static final Paint RED_PAINT = Paint()
    ..color = const Color(0xffFF0000);
  static final Paint PURPLE_PAINT = Paint()
    ..color = const Color(0xffFF00FF);
  static final Paint CYAN_PAINT = Paint()
    ..color = const Color(0xff00AAFF);
  static final Paint ORANGE_PAINT = Paint()
    ..color = const Color(0xffFFAAAA);
  static final Paint YELLOW_PAINT = Paint()
    ..color = const Color(0xffFFFF00);
  static final Paint BLUE_PAINT = Paint()
    ..color = const Color(0xff0000FF);
  static final Paint GREEN_PAINT = Paint()
    ..color = const Color(0xff00FF00);
  
  
  static final BLOCK_RECT = Vector2(20, 20).toRect();
  static final COLLISTION_TOLERANCE = 0.2;
}