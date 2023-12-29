import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class LPiece extends Piece{

  List<Square> blocks = [];
  Vector2 offset = Vector2(0, 1);
  LPiece(Vector2 startingPosition ){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    rotation = 0;
    blocks = [
      Square(BlockColor.Orange)
        ..position=startingPosition+Vector2(0,y),
      Square(BlockColor.Orange)
        ..position=startingPosition+Vector2(x,y),
      Square(BlockColor.Orange)
        ..position=startingPosition+Vector2(2*x,y),
      Square(BlockColor.Orange)
        ..position=startingPosition+Vector2(2*x,0)
          
    ];
  }
  @override
  List<Square> getBlocks() {
    // TODO: implement getBlocks
    return this.blocks;
  }

  @override
  void rotateLeft(List<Square> built) {
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    final basePosition = this.blocks[0].position - Vector2(offset.x * x, offset.y*y);
    if(rotation == 0 && rotationCase([Vector2(1,2),Vector2(1,1),Vector2(1,0),Vector2(0,0)], built, basePosition)){
      rotation = 3;
      offset = Vector2(1,2);
    } else if(rotation == 1 && rotationCase([Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(2,0)], built, basePosition)){
      rotation = 0;
      offset = Vector2(0,1);
    } else if(rotation == 2 && rotationCase([Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(2,2)], built, basePosition)){
      rotation = 1;
      offset = Vector2(1,0);
    } else if(rotation == 3 && rotationCase([Vector2(2,1),Vector2(1,1),Vector2(0,1),Vector2(0,2)], built, basePosition)){
      rotation = 2;
      offset = Vector2(2, 1);
    }
  }
  
  @override
  void rotateRight(List<Square> built) {
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    final basePosition = this.blocks[0].position - Vector2(offset.x * x, offset.y*y);
    if(rotation == 0 && rotationCase([Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(2,2)], built, basePosition)){
      rotation = 1;
      offset = Vector2(1,0);
    }  else if(rotation == 1 && rotationCase([Vector2(2,1),Vector2(1,1),Vector2(0,1),Vector2(0,2)], built, basePosition)){
      rotation = 2;
      offset = Vector2(2, 1);
    } else if(rotation == 2 && rotationCase([Vector2(1,2),Vector2(1,1),Vector2(1,0),Vector2(0,0)], built, basePosition)){
      rotation = 3;
      offset = Vector2(1,2);
    } else if(rotation == 3 && rotationCase([Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(2,0)], built, basePosition)){
      rotation = 0;
      offset = Vector2(0,1);
    }  
  }


}