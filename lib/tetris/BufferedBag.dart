import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tetris/tetris/Bag.dart';
import 'package:tetris/tetris/piece/piece.dart';

class BufferedBag{
  Bag bag;
  List<Piece> buffer = [];
  int length;
  BufferedBag(int randomSeed, int lenght):
  bag = Bag(randomSeed),
  length = lenght
  {
    getPreview();
  }

  List<Piece> getPreview(){
    while(this.buffer.length <= length){
      final piece = bag.next();
      piece.moveTo(getPiecePosition(length));
      this.buffer.add(piece);
      
    }
    return this.buffer.sublist(0, length);
  }

  Piece next(){
    if(buffer.length == 0) this.getPreview();
    final piece = this.buffer.removeAt(0);
    this.buffer.add(bag.next());
    for(int i=0;i<this.buffer.length;i++){
      this.buffer[i].moveTo(getPiecePosition(i));
    }
    piece.moveTo(Bag.STARTING_POSITION);
    return piece;
  }

  Vector2 getPiecePosition(int n){
    return Vector2(120,(-200 + 50 * n).toDouble());
  }
}