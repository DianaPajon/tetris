import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/Bag.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class Board extends PositionComponent {

  int BOARD_WIDTH = 10;
  int BOARD_HEIGHT = 20;
  int level;
  Piece? fallingPiece;
  List<Square>  built;
  List<List<Square?>> lines = [];
  Bag bag;

  Board() :
   bag = Bag(0),
   built = [],
   level = 1
  {
    for(int y = 0;y<20;y++){
      List<Square?> row = [];
      for(int x = 0;x<10;x++){
        row.add(null);
      }
      lines.add(row);
    }
    fallingPiece = bag.next();
  }

  void softDrop()
  {

  }

  void hardDrop()
  {

  }

  void rotateLeft()
  {
    this.fallingPiece!.rotateLeft(built);
  }

  void rotateRight()
  {
    this.fallingPiece!.rotateRight(built);
  }

  void moveLeft()
  {
    if(this.fallingPiece!.getBlocks().any((element) => 
      element.position.x <  -100 + Square.COLLISTION_TOLERANCE ||
      built.any((block) =>
        block.collidesWith(element.position + Vector2(-Square.BLOCK_RECT.toVector2().x, 0))
      )
    )) return;
    this.fallingPiece!.getBlocks().forEach((element) {
      element.position = element.position + Vector2(-Square.BLOCK_RECT.toVector2().x, 0);
    });
  }

  void moveRight(){
    if(this.fallingPiece!.getBlocks().any((element) => 
      element.position.x + element.size.x > 100 - Square.COLLISTION_TOLERANCE ||
      built.any((block) =>
        block.collidesWith(element.position + Vector2(Square.BLOCK_RECT.toVector2().x, 0))
      )
    )) return;
    this.fallingPiece!.getBlocks().forEach((element) {
      element.position = element.position + Vector2(Square.BLOCK_RECT.toVector2().x, 0);
    });
  }

  int tick(World world)
  {
    if(fallingPiece != null){
      if(touchesBuilt(fallingPiece!, built) || touchesFloor(fallingPiece!)){
        final xsize = Square.BLOCK_RECT.width.toInt();
        final ysize = Square.BLOCK_RECT.height.toInt();
        List<Square> blocks = fallingPiece!.getBlocks();
        built.addAll(blocks);
        List<Block> positions = blocks.map((square) => 
          Block(
            ((square.position.x + 100)/xsize).toInt(),
            ((200 - square.position.y)/ysize).toInt()
        )).toList();
        for(int i = 0;i<blocks.length;i++){
          lines[positions[i].y][positions[i].x] = blocks[i];
        }
        for(int y = 0;y<20;y++){
          if(!lines[y].any((element) => element == null)){
            lines[y].forEach((block) {
              world.remove(block!);
              built.remove(block);
            });
            for(int y2 = y;y2<19;y2++){
              lines[y2] = lines[y2+1];
              lines[y2].forEach((element) {
                if(element != null){
                  element.position.y = element.position.y + ysize;
                }
              });
            }
            lines[19] = [null, null, null, null, null, null, null, null, null, null];
          } 
        }
        this.fallingPiece = bag.next();
        world.addAll(fallingPiece!.getBlocks());
      } else{
        fallingPiece!.getBlocks().forEach((element) {
          element.position = element.position + Vector2(0, 20);
        });
      }
    }
    return 1;
  }

  @override
  void render(Canvas canvas){
    canvas.drawRRect(CARD_RECT,WHITE_BORDER_PAINT);
  }

  bool touchesBuilt(Piece piece, List<Square> built){
    List<Square> blocks = piece.getBlocks();
    return built.any(
          (builtBlock) => blocks.any(
              (pieceBlock) => pieceBlock.touchesBlock(builtBlock.position)
          )
    );
  }

  bool touchesFloor(Piece piece){
    List<Square> blocks = piece.getBlocks();
    return blocks.any((block) => 
      block.position.y + block.size.y > 190
    );
  }
  static final BOARD_SIZE = Vector2(200, 400);


  static final Paint WHITE_BORDER_PAINT = Paint()
    ..color = const Color(0xffFFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  static final RRect CARD_RECT = RRect.fromRectAndRadius(
    BOARD_SIZE.toRect(),
    const Radius.circular(5),
  );
}