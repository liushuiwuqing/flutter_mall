import 'package:flutter/material.dart';
import 'package:mall/constant/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetWorkErrorView extends StatelessWidget {
  VoidCallback callback;

  NetWorkErrorView(this.callback);

  @override
  Widget build(BuildContext context) {
    print('NetWorkErrorView................................');
    return InkWell(
      onTap: callback,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //控制上中下?
            crossAxisAlignment: CrossAxisAlignment.center, //默认的,因此这里没发现作用?
            children: <Widget>[
              Image.asset(
                "images/network_error.png",
                height: ScreenUtil.instance.setWidth(120.0),
                width: ScreenUtil.instance.setWidth(120.0),
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
      ),
    );
  }
}
