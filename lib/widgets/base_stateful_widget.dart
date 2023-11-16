import 'package:flutter/widgets.dart';
import '../common/screen_adapter.dart';

/// StatefulWidget基类
abstract class BaseStatefulWidget extends StatefulWidget with ScreenAdapter {
  BaseStatefulWidget({Key? key}) : super(key: key);
}
