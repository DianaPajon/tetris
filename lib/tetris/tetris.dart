import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tetris/tetris/board.dart';

class Tetris extends FlameGame with KeyboardEvents{
  Board board = Board();
  var time  = 0.toDouble();
  @override
  void onLoad() async{
    board.position = Vector2(-100, -200);
    world.add(board);
  }



    @override
    void update(double dt) {
      super.update(dt);
      time += dt;
      final divisor = (board.level/10).ceil();
      if(time >= 1/divisor){
        time = 0;
        board.tick(world);
      }
    }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ){
      if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        board.moveLeft();
      } else if(keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        board.moveRight();
      } else if(keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        board.tick(world);
      } else  if(keysPressed.contains(LogicalKeyboardKey.keyZ)) {
        board.rotateLeft();
      } else if(keysPressed.contains(LogicalKeyboardKey.keyX)) {
        board.rotateRight();
      } else {
        return KeyEventResult.ignored;
      }
      return KeyEventResult.handled;
    }
    
}