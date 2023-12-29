import 'dart:math';

import 'package:flame/components.dart';
import 'package:tetris/tetris/piece/IPiece.dart';
import 'package:tetris/tetris/piece/JPiece.dart';
import 'package:tetris/tetris/piece/LPiece.dart';
import 'package:tetris/tetris/piece/OPiece.dart';
import 'package:tetris/tetris/piece/SPiece.dart';
import 'package:tetris/tetris/piece/TPiece.dart';
import 'package:tetris/tetris/piece/ZPiece.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/pieces.dart';

class Bag{
  List<Pieces> current;
  Random r;
  Bag(int randomSeed) :
    current = [],
    r = new Random(randomSeed);

  Piece next(){
    if(this.current.length > 0){
      var removed = this.current.removeAt(0);
      switch(removed){
        case Pieces.I:
          return new IPiece(STARTING_POSITION);
        case Pieces.O:
          return new OPiece(STARTING_POSITION);
        case Pieces.S:
          return new SPiece(STARTING_POSITION);
        case Pieces.Z:
          return new ZPiece(STARTING_POSITION);
        case Pieces.L:
          return new LPiece(STARTING_POSITION);
        case Pieces.J:
          return new JPiece(STARTING_POSITION);
        case Pieces.T:
          return new TPiece(STARTING_POSITION);
      }
    } else {
      this.current = [Pieces.I,Pieces.L,Pieces.J,Pieces.S,Pieces.Z,Pieces.O,Pieces.T];
      //this.current = [Pieces.I];
      this.current.shuffle(r);
      return next();
    }
  }

  static final Vector2 GRID_SIZE = Vector2(40, 40);
  static final Vector2 STARTING_POSITION = Vector2(-20, -200);
}