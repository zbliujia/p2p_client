import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan.dart';
import 'package:p2p_client/pages/index_file.dart';
import 'package:p2p_client/pages/index_home.dart';
import 'package:p2p_client/pages/index_me.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class IndexPage extends BaseStatefulWidget {
  final Object? arguments;

  IndexPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _IndexPageState();
}

class _IndexPageState extends BaseState<IndexPage> {
  int _selectedIndex = 0;
  late List<Widget> pages;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pages = [
      IndexHomePage(),
      IndexFilePage(),
      IndexMePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("我的设备"),
      centerTitle: true,
    );
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_present),
            label: '文件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          pageController.jumpToPage(index);
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // extendBodyBehindAppBar: true,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
