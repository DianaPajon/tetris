import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tetris/tetris/piece/square.dart';

class Piece{
  List<Square> getBlocks(){return [];}
  void rotateLeft(List<Square> built){}
  void rotateRight(List<Square> built){}
  int rotation = 0;

  bool rotationCase(List<Vector2> offSets, List<Square> built, Vector2 headPosition){
      final x = Square.BLOCK_RECT.toVector2().x;
      final y = Square.BLOCK_RECT.toVector2().y;
      
      final rotatedPositions = [
        headPosition + Vector2(x*offSets[0].x, y*offSets[0].y),
        headPosition + Vector2(x*offSets[1].x, y*offSets[1].y),
        headPosition + Vector2(x*offSets[2].x, y*offSets[2].y),
        headPosition + Vector2(x*offSets[3].x, y*offSets[3].y)
      ];
      if(rotatedPositions.any((position) => 
        offLimits(position) ||
        built.any((element) => element.collidesWith(position))
      )){
        return false;
      }
      rotate(rotatedPositions);
      return true;
  }
  void rotate(List<Vector2> newPositions) {
    for(int i = 0;i < newPositions.length;i++){
      this.getBlocks()[i].position = newPositions[i];
    }
  }

  bool offLimits(Vector2 position){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    return position.x <-100 ||
    position.x + x > 100 ||
    position.y + y > 200;
  }
}