import 'package:event_bus/event_bus.dart';

//创建EventBus消息总线
EventBus loginEventBus = EventBus();

class LoginEvent {
  bool isLogin;
  String nickName;
  String url;

  LoginEvent(this.isLogin, {this.nickName, this.url});
}
