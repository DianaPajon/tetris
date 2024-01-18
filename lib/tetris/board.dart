import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tetris/tetris/Bag.dart';
import 'package:tetris/tetris/BufferedBag.dart';
import 'package:tetris/tetris/piece/piece.dart';
import 'package:tetris/tetris/piece/square.dart';

class Board extends PositionComponent {

  int BOARD_WIDTH = 10;
  int BOARD_HEIGHT = 20;
  final xsize = Square.BLOCK_RECT.width.toInt();
  final ysize = Square.BLOCK_RECT.height.toInt();
  int level;
  Piece? fallingPiece;
  List<Square>  built;
  List<List<Square?>> lines = [];
  BufferedBag bag;
  bool set = false;
  Board() :
   bag = BufferedBag(0, 4),
   built = [],
   level = 1
  {
    
  }

  setUp(World world){
   built = [];
   level = 1;
   lines = [];
    for(int y = 0;y<24;y++){
      List<Square?> row = [];
      for(int x = 0;x<10;x++){
        row.add(null);
      }
      lines.add(row);
    }
    if(!set) fallingPiece = bag.next();
    world.addAll(fallingPiece!.getBlocks());
    bag.getPreview().forEach((element) {
      world.addAll(element.getBlocks());
    });

    set = true;
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
    if(!set) setUp(world);
    bag.getPreview().forEach((element) {
      world.removeAll(element.getBlocks());
    });
    bag.getPreview().forEach((element) {
      world.addAll(element.getBlocks());
    });
    if(fallingPiece != null){
      if(shouldFall(fallingPiece!, built)){
        /*
          en cada tick del relog voy a hacer.
          if(la pieca debería seguir cayendo) cae();
          si no (la mezclo con los bloques armados) 


          cae:
            le agrego un a la poisicion verticl de la piza
        */

        mergeBlocks();
        for(int y = 0;y<20;y++){
          var cleared = clearUpwards(world, y);
          if(cleared) y--;
        }
        removePreview(world);
        this.fallingPiece = bag.next();
        if(fallingPiece!.getBlocks().any((block) => 
          built.any((builtBlock) => block.collidesWith(builtBlock.position))
        )){
          world.removeAll(built);
          setUp(world);
          return level;
        } else{
          bag.getPreview().forEach((element) {
            world.addAll(element.getBlocks());
          });
          world.addAll(fallingPiece!.getBlocks());
        }
      } else{
        fallingPiece!.getBlocks().forEach((element) {
          element.position = element.position + Vector2(0, 20);
        });
      }
    }
    return level;
  }

  bool shouldFall(Piece fallingPiece, List<Square> built){
    return touchesBuilt(fallingPiece, built) || touchesFloor(fallingPiece);
  }

  void mergeBlocks(){
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
  }

  removePreview(World world){
    bag.getPreview().forEach((element) {
      world.removeAll(element.getBlocks());
    });
  }

  void landPiece(World world){
    bag.getPreview().forEach((element) {
      world.removeAll(element.getBlocks());
    });
    this.fallingPiece = bag.next();
  }

  bool clearUpwards(World world, int y){
    if(!lines[y].any((element) => element == null)){
            lines[y].forEach((block) {
              world.remove(block!);
              built.remove(block);
            });
      level++;
      print("newLevel:" + level.toString());
      for(int y2 = y;y2<19;y2++){
        lines[y2] = lines[y2+1];
        lines[y2].forEach((element) {
          if(element != null){
            element.position.y = element.position.y + ysize;
          }
        });
      }
      lines[19] = [null, null, null, null, null, null, null, null, null, null];
      return true;
    }
    return false;
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