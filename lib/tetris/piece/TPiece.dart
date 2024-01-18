import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class TPiece extends Piece{
  List<Square> blocks = [];
  Vector2 offset = Vector2(0, 0);
  List<List<Vector2>> rotations = [
    [Vector2(0,1),Vector2(1,1),Vector2(1,0),Vector2(2,1)],
    [Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(2,1)],
    [Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(1,2)],
    [Vector2(0,1),Vector2(1,0),Vector2(1,1),Vector2(1,2)]
  ];

  TPiece(Vector2 startingPosition ){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    rotation = 0;
    blocks = [
      Square(BlockColor.Purple)
        ..position=startingPosition+Vector2(0,y),
      Square(BlockColor.Purple)
        ..position=startingPosition+Vector2(x,y),
      Square(BlockColor.Purple)
        ..position=startingPosition+Vector2(x,0),
      Square(BlockColor.Purple)
        ..position=startingPosition+Vector2(2*x,y)
          
    ];
  }
  @override
  List<Square> getBlocks() {
    return this.blocks;
  }
  
  
  List<List<Vector2>> getPositions(){ return rotations;}
  Vector2 getOffset(){return offset;}
  void setOffset(Vector2 offset) {this.offset = offset;}
  int getPosition(){return rotation;}
}