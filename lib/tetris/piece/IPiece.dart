
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class IPiece extends Piece{
  List<Square> blocks = [];
  Vector2 offset = Vector2(0, 0);
  List<List<Vector2>> rotations = [
    [Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(3,1)],
    [Vector2(2,0),Vector2(2,1),Vector2(2,2),Vector2(2,3)],
    [Vector2(0,2),Vector2(1,2),Vector2(2,2),Vector2(3,2)],
    [Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(1,3)]
  ];

  IPiece(Vector2 startingPosition ){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    rotation = 0;
    blocks = [
      Square(BlockColor.Cyan)
        ..position=startingPosition+Vector2(0,y),
      Square(BlockColor.Cyan)
        ..position=startingPosition+Vector2(x,y),
      Square(BlockColor.Cyan)
        ..position=startingPosition+Vector2(2*x,y),
      Square(BlockColor.Cyan)
        ..position=startingPosition+Vector2(3*x,y)
          
    ];
  }
  @override
  List<Square> getBlocks() {
    return this.blocks;
  }
  
  


  List<List<Vector2>> getPositions(){ return rotations;}
  Vector2 getOffset(){return offset;}
  int getPosition(){return rotation;}



  Vector2 getRotation(int from, int to, int test){
    if(from == 0 && to == 1){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-2, 0);
        case 3:
          return Vector2(1, 0);
        case 4:
          return Vector2(-2, -1);
        case 5:
          return Vector2(1, 2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 1 && to == 0){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(2, 0);
        case 3:
          return Vector2(-1, 0);
        case 4:
          return Vector2(2, 1);
        case 5:
          return Vector2(-1, -2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 1 && to == 2){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(2, 0);
        case 4:
          return Vector2(-1, 2);
        case 5:
          return Vector2(2, -1);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 2 && to == 1){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(-2, 0);
        case 4:
          return Vector2(1, -2);
        case 5:
          return Vector2(-2, 1);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 2 && to == 3){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(2, 0);
        case 3:
          return Vector2(-1, 0);
        case 4:
          return Vector2(2, 1);
        case 5:
          return Vector2(-1, -2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 3 && to == 2){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-2, 0);
        case 3:
          return Vector2(1, 0);
        case 4:
          return Vector2(-2, -1);
        case 5:
          return Vector2(1, 2);
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 3 && to == 0){
        switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(1, 0);
        case 3:
          return Vector2(-2, 0);
        case 4:
          return Vector2(1, -2);
        case 5:
          return Vector2(-2, 1);        
        default:
          return Vector2(0, 0);
      }
    }
    if(from == 0 && to == 3){
      switch(test){
        case 1:
          return Vector2(0, 0);
        case 2:
          return Vector2(-1, 0);
        case 3:
          return Vector2(2, 0);
        case 4:
          return Vector2(-1, 2);
        case 5:
          return Vector2(2, -1);
        default:    
      }
    }
    return Vector2(0, 0);
  }
}