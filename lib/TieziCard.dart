import 'package:flutter/material.dart';

//刘旭
//20-09-28
//email:1697935859@qq.com
class TieziCard extends StatelessWidget {
  TieziCard({Key key, this.title, this.avatarUrl, this.username})
      : super(key: key);
  String title;
  String avatarUrl;
  String username;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 110,
      child: Card(
        elevation: 15.0, //阴影
        shadowColor: Colors.grey[300], //阴影颜色
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
        child: Padding(
          // 分别指定四个方向的补白
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: SizedBox(
              // height: 120,
              // width: 90,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              ClipOval(
                  child: Image(
                    image: //AssetImage("images/avatar/avatar_1.png"),
                    NetworkImage(avatarUrl),
                    width: 35.0,
                    height: 35.0,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                username,
                style: TextStyle(fontSize: 12),
              )
            ],
          )),
        ),
      ),
    );
  }
}
