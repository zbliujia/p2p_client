import 'package:flutter/widgets.dart';
import 'package:p2p_client/common/router_util.dart';
import 'package:p2p_client/common/screen_adapter.dart';

/// State基类
abstract class BaseState<T extends StatefulWidget> extends State<T>
    with ScreenAdapter , RouteAware{
  bool hasObserver = false;

  @override
  void dispose() {
    RouterUtil.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasObserver) {
      RouterUtil.routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
    hasObserver = true;
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }else{
      debugPrint("page has been destroyed,ignored this setState");
    }
  }
}
