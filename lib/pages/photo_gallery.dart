import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/network/device_api.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class PhotoGalleryPage extends BaseStatefulWidget {
  final Object? arguments;

  PhotoGalleryPage({super.key, this.arguments});

  @override
  State createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends BaseState<PhotoGalleryPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeviceApi.getFileList("image");
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("图库"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            final List<AssetEntity>? result = await AssetPicker.pickAssets(context);
            if (result?.isNotEmpty == true) {
              final file = await result?[0].file;
              DeviceApi.uploadFile(file?.path ?? "");
            }
          },
        ),
      ],
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [

            ],
          )),
    );
  }
}
