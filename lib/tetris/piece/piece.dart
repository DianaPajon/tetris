import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tetris/tetris/piece/square.dart';

class Piece{
  List<Square> getBlocks(){return [];}
  List<List<Vector2>> getPositions(){ return [];}
  Vector2 getOffset(){return Vector2(1,1);}
  int getPosition(){return 0;}
  int rotation = 0;
  void setOffset(Vector2 offset) {;}

  bool rotationCase(List<Vector2> offSets, List<Square> built, Vector2 headPosition, int from, int to){
      final x = Square.BLOCK_RECT.toVector2().x;
      final y = Square.BLOCK_RECT.toVector2().y;
      for(int test = 1; test<=5;test++){
        var kicks = getRotation(from, to, test);
        final rotatedPositions = [
          headPosition + Vector2(x*(offSets[0].x + kicks.x), y*(offSets[0].y - kicks.y)),
          headPosition + Vector2(x*(offSets[1].x + kicks.x), y*(offSets[1].y - kicks.y)),
          headPosition + Vector2(x*(offSets[2].x + kicks.x), y*(offSets[2].y - kicks.y)),
          headPosition + Vector2(x*(offSets[3].x + kicks.x), y*(offSets[3].y - kicks.y))
        ];
        if(rotatedPositions.any((position) => 
          offLimits(position) ||
          built.any((element) => element.collidesWith(position))
        )){
          continue;
        }
        rotate(rotatedPositions);
        return true;
      }
      return false;
  }
  void rotate(List<Vector2> newPositions) {
    for(int i = 0;i < newPositions.length;i++){
      this.getBlocks()[i].position = newPositions[i];
    }
  }

  void moveTo(Vector2 newPosition){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;

    final shape = this.getPositions()[this.getPosition()];
    this.rotate(shape.map((coordinates) => 
      newPosition + Vector2(x*coordinates.x, y * coordinates.y)
    ).toList());
    
    
  }

  bool offLimits(Vector2 position){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    return position.x <-100 ||
    position.x + x > 100 ||
    position.y + y > 200;
  }


  void rotateLeft(List<Square> built) {
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    final offset = this.getOffset();
    final basePosition = this.getBlocks()[0].position - Vector2(offset.x * x, offset.y*y);
    final rotations = this.getPositions();
    if(rotation == 0 && rotationCase(rotations[3], built, basePosition,0,3)){
      rotation = 3;
      this.setOffset(rotations[3][0]);
    } else if(rotation == 1 && rotationCase(rotations[0], built, basePosition,1,0)){
      rotation = 0;
      this.setOffset(rotations[0][0]);
    } else if(rotation == 2 && rotationCase(rotations[1], built, basePosition,2,1)){
      rotation = 1;
      this.setOffset(rotations[1][0]);
    } else if(rotation == 3 && rotationCase(rotations[2], built, basePosition,3,2)){
      rotation = 2;
      this.setOffset(rotations[2][0]);
    }
  }
  

  void rotateRight(List<Square> built) {
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    final offset = this.getOffset();
    final basePosition = this.getBlocks()[0].position - Vector2(offset.x * x, offset.y*y);
    final rotations = this.getPositions();
    if(rotation == 0 && rotationCase(rotations[1], built, basePosition,0,1)){
      rotation = 1;
      this.setOffset(rotations[1][0]);
    }  else if(rotation == 1 && rotationCase(rotations[2], built, basePosition,1,2)){
      rotation = 2;
      this.setOffset(rotations[2][0]);
    } else if(rotation == 2 && rotationCase(rotations[3], built, basePosition,2,3)){
      rotation = 3;
      this.setOffset(rotations[3][0]);
    } else if(rotation == 3 && rotationCase(rotations[0], built, basePosition,3,0)){
      rotation = 0;
      this.setOffset(rotations[0][0]);
    }  
  }

  Vector2 getRotation(int from, int to, int test){
    if(from == 0 && to == 1){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(-1, 1);
        case 4:
          return Vector2(0, -2);
        case 5:
          return Vector2(-1, -2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 1 && to == 0){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(1, -1);
        case 4:
          return Vector2(0, 2);
        case 5:
          return Vector2(1, 2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 1 && to == 2){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(1, -1);
        case 4:
          return Vector2(0, 2);
        case 5:
          return Vector2(1, 2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 2 && to == 1){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(-1, -1);
        case 4:
          return Vector2(0, -2);
        case 5:
          return Vector2(-1, -2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 2 && to == 3){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(1, 1);
        case 4:
          return Vector2(0, -2);
        case 5:
          return Vector2(1, -2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 3 && to == 2){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(-1, -1);
        case 4:
          return Vector2(0, 2);
        case 5:
          return Vector2(-1, 2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 3 && to == 0){
        switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(-1, -1);
        case 4:
          return Vector2(0, 2);
        case 5:
          return Vector2(-1, 2);        
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 0 && to == 3){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(1, 1);
        case 4:
          return Vector2(0, -2);
        case 5:
          return Vector2(1, -2);
        default:    
      }
    }
    return Vector2(0, 0);
  }
}