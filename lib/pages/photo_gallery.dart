import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:p2p_client/network/base.dart';
import 'package:p2p_client/network/device_api.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class PhotoGalleryPage extends BaseStatefulWidget {
  final Object? arguments;

  PhotoGalleryPage({super.key, this.arguments});

  @override
  State createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends BaseState<PhotoGalleryPage> {
  List _elements = [
    {'name': 'John', 'group': 'Team A'},
    {'name': 'Will', 'group': 'Team B'},
    {'name': 'Beth', 'group': 'Team A'},
    {'name': 'Miranda', 'group': 'Team B'},
    {'name': 'Mike', 'group': 'Team C'},
    {'name': 'Danny', 'group': 'Team C'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DeviceApi.getFileList("image");
    // DeviceApi.getDirInfo("/s1/data/");
    DeviceApi.getDirInfo("/s1/data/image/");
  }

  Widget photoItem(String photoUrl) {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: ExtendedNetworkImageProvider(photoUrl),
        ),
      ),
    );
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
            final List<AssetEntity>? result =
                await AssetPicker.pickAssets(context);
            if (result?.isNotEmpty == true) {
              final file = await result?[0].file;
              try {
                await DeviceApi.uploadFile(file?.path ?? "");
                EasyLoading.showToast("上传成功");
              } on HttpError catch (e) {
                EasyLoading.showError(e.message);
              } catch (e) {
                EasyLoading.showError(e.toString());
              }
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
          child: GroupedListView<dynamic, String>(
            padding: EdgeInsets.zero,
            elements: _elements,
            groupBy: (element) => element['group'],
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1['name'].compareTo(item2['name']),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (c, element) {
              return Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: SizedBox(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    leading: const Icon(Icons.account_circle),
                    title: Text(element['name']),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
