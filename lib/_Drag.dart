import 'package:flutter/material.dart';

//刘旭
//20-09-07 悬浮球
//email:1697935859@qq.com
class Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<Drag> with SingleTickerProviderStateMixin {
  double _top = 100.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: ClipOval(
                child: Image(
                    image: AssetImage("images/appicon.png"), width: 50.0)),

            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
//              Navigator.push( context,
//                      MaterialPageRoute(builder: (context) {
//                        return MainRecommendCity() ;
//                      }));
            },
            onTap: () {
              //点击
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                if ((_top + e.delta.dy) <= 0) {
                  _top = 2;
                } else if ((_top + e.delta.dy) > 400) {
                  _top = 400;
                } else {
                  _top += e.delta.dy;
                }
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}
