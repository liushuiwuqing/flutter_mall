import 'package:flutter/material.dart';
import 'package:mall/constant/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      width: double.maxFinite, //我发现width和height不能都使用double.maxFinite,否则整个页面是一片空白
//      height: double.maxFinite,
      width: double.infinity,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/no_data.png",
              width: ScreenUtil.instance.setWidth(120.0),
              height: ScreenUtil.instance.setHeight(120.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(20.0)),
            ),
            Text(
              Strings.NO_DATA_TEXT,
              style: TextStyle(fontSize: ScreenUtil.instance.setSp(28.0), color: Colors.deepOrangeAccent),
            )
          ],
        ),
      ),
    );
  }
}
