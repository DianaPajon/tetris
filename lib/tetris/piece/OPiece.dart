import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class OPiece extends Piece {

  List<Square> blocks = [];
  Vector2 startingPosition;
  Vector2 offset = Vector2(1, 0);
  List<List<Vector2>> rotations = [
    [Vector2(1,0),Vector2(2,0),Vector2(1,1),Vector2(2,1)],
    [Vector2(1,0),Vector2(2,0),Vector2(1,1),Vector2(2,1)],
    [Vector2(1,0),Vector2(2,0),Vector2(1,1),Vector2(2,1)],
    [Vector2(1,0),Vector2(2,0),Vector2(1,1),Vector2(2,1)]
  ];
  OPiece(this.startingPosition){
    blocks = [
      Square(BlockColor.Yellow)
        ..position=startingPosition,
      Square(BlockColor.Yellow)
        ..position=startingPosition+Vector2(0,20),
      Square(BlockColor.Yellow)
        ..position=startingPosition+Vector2(20,0),
      Square(BlockColor.Yellow)
        ..position=startingPosition+Vector2(20,20)
          
    ];
  }
  
  @override
  List<Square> getBlocks() {
      return this.blocks;
  }
  
  @override
  void rotateLeft(List<Square> built) {
    //no hace nada
  }
  
  @override
  void rotateRight(List<Square> built) {
    //no hace nada
  }
List<List<Vector2>> getPositions(){ return rotations;}
  Vector2 getOffset(){return offset;}
  int getPosition(){return rotation;}
}