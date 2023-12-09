import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DeviceQRScanPage extends BaseStatefulWidget {
  final Object? arguments;

  DeviceQRScanPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _DeviceQRScanPageState();
}

class _DeviceQRScanPageState extends BaseState<DeviceQRScanPage> {
  bool isPop = false;
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("扫描设备"),
      centerTitle: true,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: MobileScanner(
        // fit: BoxFit.contain,
        scanWindow: Rect.fromLTWH((1.sw - 200.w) / 2, 0.3.sh, 200.w, 200.w),
        overlay: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.3.sh),
              child: Image.asset(
                'assets/images/qr_code.png',
                width: 200.w,
                height: 200.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.2.sh),
              child: Text(
                "将二维码放入框内即可",
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            )
          ],
        ),
        onDetect: (capture) {
          if (isPop) {
            return;
          }
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isEmpty) {
            return;
          }
          EasyLoading.showSuccess(barcodes.first.rawValue ?? "");
          isPop = true;
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
