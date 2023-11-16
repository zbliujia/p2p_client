import 'package:flutter/widgets.dart';
import '../common/screen_adapter.dart';

/// StatelessWidget基类
abstract class BaseStatelessWidget extends StatelessWidget with ScreenAdapter {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  @protected
  Widget buildWidget(BuildContext context);
}
