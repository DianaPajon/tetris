import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/piece/blockcolor.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class OPiece extends Piece {

  List<Square> blocks = [];
  Vector2 startingPosition;
  Vector2 offset = Vector2(0, 9);
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
    //nothing to do
  }
  
  @override
  void rotateRight(List<Square> built) {
    //nothing to do
  }

}