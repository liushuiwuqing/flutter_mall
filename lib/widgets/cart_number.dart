import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/event/cart_number_event.dart';

typedef OnNumberChange(int number);

class CartNumberView extends StatefulWidget {
  OnNumberChange onNumberChange;
  var _number;

  CartNumberView(this._number, this.onNumberChange);

  @override
  _CartNumberViewState createState() => _CartNumberViewState();
}

class _CartNumberViewState extends State<CartNumberView> {
  var goodsNumber;
  OnNumberChange onNumberChange;

  @override
  void initState() {
    super.initState();
    goodsNumber = widget._number;
    onNumberChange = widget.onNumberChange;
  }

  _listener() {
    cartNumberEventBus.on<CartNumberEvent>().listen((CartNumberEvent cartNumberEvent) {
      setState(() {
        print('没有看到执行?.........');
        goodsNumber = cartNumberEvent.number;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("CartNumberView build");
    _listener();
    return Container(
      width: ScreenUtil.instance.setWidth(150),
      //设置成150,提示:A RenderFlex overflowed by 16 pixels on the right.
      height: ScreenUtil.instance.setWidth(50),
      child: Row(
        children: <Widget>[
          InkWell(
              onTap: () => _reduce(),
              child: Container(
                width: ScreenUtil.instance.setWidth(50),
                height: double.infinity,
                //由此可以看出,受父组件高度的影响
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)), border: Border.all(color: Colors.green, width: 1)),
                child: Text(
                  "-",
                  style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(26.0)),
                ),
              )),
          Container(
            width: ScreenUtil.instance.setWidth(50),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(shape: Border(top: BorderSide(color: Colors.green, width: 1.0), bottom: BorderSide(color: Colors.green, width: 1.0))),
            child: Text(
              "$goodsNumber",
              style: TextStyle(color: Colors.black54, fontSize: ScreenUtil.instance.setSp(26.0)),
            ),
          ),
          InkWell(
              onTap: () => _add(),
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil.instance.setWidth(50),
                height: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)), border: Border.all(color: Colors.green, width: 1)),
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.black54, fontSize: ScreenUtil.instance.setSp(26.0)),
                ),
              )),
        ],
      ),
    );
  }

  _reduce() {
    if (goodsNumber > 1) {
      setState(() {
        goodsNumber = goodsNumber - 1;
      });
    }
    print("减少之前widget._number:${widget._number}");
    onNumberChange(goodsNumber);
  }

  _add() {
    print("增加之前goodsNumber:$goodsNumber");
    /*setState(() {
      //我感觉不用把下面这句放到setState代码块里面,因为onNumberChange方法会执行build方法
      goodsNumber = goodsNumber + 1;
    });*/
    goodsNumber = goodsNumber + 1;
    print("增加之后goodsNumber:$goodsNumber");
    onNumberChange(goodsNumber);
    /*await Future.delayed(Duration(seconds: 5)).then((_) {
      print('onValue111');
    });
     Future.delayed(Duration(seconds: 5)).then((_) {
      print('onValue222');
    });*/
  }
}
