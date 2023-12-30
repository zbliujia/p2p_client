import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class IndexHomePage extends BaseStatefulWidget {
  final Object? arguments;

  IndexHomePage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _IndexHomePageState();
}

class _IndexHomePageState extends BaseState<IndexHomePage> {
  List<Widget> getSelfIcons() {
    List<Widget> icons = [];
    icons.add(getIcon("图库", () {

    }));
    return icons;
  }

  Widget getIcon(String text, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60.w,
        child: Column(
          children: [
            Image.asset(
              'assets/images/home_pic_icon.png',
              width: 34.w,
              height: 34.w,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF3D3D3D)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("首页"),
      centerTitle: true,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  width: 347.w,
                  height: 198.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                  child: Text(
                    "个人空间",
                    style: TextStyle(
                        fontSize: 12.sp, color: const Color(0xFF86868C)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  padding: EdgeInsets.only(left: 33.w, right: 33.w),
                  width: 347.w,
                  height: 85.w,
                  child: Row(
                    children: getSelfIcons(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
