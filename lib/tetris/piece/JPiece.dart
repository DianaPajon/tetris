
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class JPiece extends Piece{
  List<Square> blocks = [];
  Vector2 offset = Vector2(0, 0);
  List<List<Vector2>> rotations = [
    [Vector2(0,0),Vector2(0,1),Vector2(1,1),Vector2(2,1)],
    [Vector2(2,0),Vector2(1,0),Vector2(1,1),Vector2(1,2)],
    [Vector2(2,2),Vector2(2,1),Vector2(1,1),Vector2(0,1)],
    [Vector2(0,2),Vector2(1,2),Vector2(1,1),Vector2(1,0)]
  ];

  JPiece(Vector2 startingPosition ){
    final x = Square.BLOCK_RECT.toVector2().x;
    final y = Square.BLOCK_RECT.toVector2().y;
    rotation = 0;
    blocks = [
      Square(BlockColor.Blue)
        ..position=startingPosition+Vector2(0,0),
      Square(BlockColor.Blue)
        ..position=startingPosition+Vector2(0,y),
      Square(BlockColor.Blue)
        ..position=startingPosition+Vector2(x,y),
      Square(BlockColor.Blue)
        ..position=startingPosition+Vector2(2*x,y)
          
    ];
  }
  @override
  List<Square> getBlocks() {
    return this.blocks;
  }
  
  

  List<List<Vector2>> getPositions(){ return rotations;}
  Vector2 getOffset(){return offset;}
  int getPosition(){return rotation;}
  void setOffset(Vector2 offset) {this.offset = offset;}
}