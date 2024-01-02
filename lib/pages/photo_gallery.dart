import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/network/base.dart';
import 'package:p2p_client/network/device_api.dart';
import 'package:p2p_client/network/device_base.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/group_grid_view.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class PhotoGalleryPage extends BaseStatefulWidget {
  final Object? arguments;

  PhotoGalleryPage({super.key, this.arguments});

  @override
  State createState() => _PhotoGalleryPageState();
}

class PhotoGroupModel {
  PhotoGroupModel(
      {required this.sectionName, required this.listItems, this.footerName});

  final String sectionName;
  final String? footerName;
  final List<String> listItems;
}

class _PhotoGalleryPageState extends BaseState<PhotoGalleryPage> {
  final List<PhotoGroupModel> dataSource = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // DeviceApi.getFileList("image");
    // DeviceApi.getDirInfo("/s1/data/");
    final result = await DeviceApi.getDirInfo("/s1/data/image/");
    dataSource.clear();
    if (result.items?.isNotEmpty == true) {
      for (var item in result.items!) {
        if (item.isFile != true) {
          continue;
        }
        var groupNames = item.lastModified?.split(" ");
        if (groupNames?.length != 2) {
          continue;
        }
        if (dataSource.isEmpty ||
            dataSource.last.sectionName != groupNames?[0]) {
          dataSource.add(PhotoGroupModel(
            sectionName: groupNames?[0] ?? "",
            listItems: [HttpUtil.getFileUrl(item.name ?? "")],
          ));
        } else {
          dataSource.last.listItems.add(HttpUtil.getFileUrl(item.name ?? ""));
        }
      }
    }
    setState(() {});
    _refreshController.loadNoData();
  }

  void _onRefresh() async {
    await getData();
    _refreshController.refreshCompleted();
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

  Widget getListWidget() {
    if (dataSource.isEmpty == true) {
      return const SizedBox();
    }
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      // header: const WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      // onLoading: _onLoading,
      child: GroupGridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 16),
          sectionCount: dataSource.length,
          headerForSection: (section) => Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(dataSource[section].sectionName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold))),
          // footerForSection: (section) {
          //   final footer = dataSource[section].footerName;
          //   return footer != null
          //       ? Container(
          //           padding: const EdgeInsets.only(top: 12, bottom: 32),
          //           child:
          //               Text(footer, style: const TextStyle(fontSize: 16)))
          //       : const SizedBox(height: 32);
          // },
          itemInSectionBuilder: (_, indexPath) {
            final data =
                dataSource[indexPath.section].listItems[indexPath.index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(
                data,
                headers: HttpUtil.getCookie(),
                cache: true,
                fit: BoxFit.fitWidth,
              ),
            );
          },
          itemInSectionCount: (section) =>
              dataSource[section].listItems.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("图库"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            final List<AssetEntity>? result = await AssetPicker.pickAssets(
                context,
                pickerConfig: const AssetPickerConfig(
                    maxAssets: 1,
                    requestType: RequestType.image,
                    specialPickerType: SpecialPickerType.noPreview));
            if (result?.isNotEmpty == true) {
              final file = await result?[0].file;
              try {
                await DeviceApi.uploadFile(file?.path ?? "");
                EasyLoading.showToast("上传成功");
                getData();
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
              left: 16.w,
              right: 16.w,
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: getListWidget(),
          // child: ExtendedImage.network(imageUrl, headers: HttpUtil.getCookie(),),
          // child: GroupedListView<dynamic, String>(
          //   padding: EdgeInsets.zero,
          //   elements: _elements,
          //   groupBy: (element) => element['group'],
          //   groupComparator: (value1, value2) => value2.compareTo(value1),
          //   itemComparator: (item1, item2) =>
          //       item1['name'].compareTo(item2['name']),
          //   order: GroupedListOrder.DESC,
          //   useStickyGroupSeparators: true,
          //   groupSeparatorBuilder: (String value) => Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       value,
          //       textAlign: TextAlign.center,
          //       style:
          //           const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          //   itemBuilder: (c, element) {
          //     return Card(
          //       elevation: 8.0,
          //       margin:
          //           const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          //       child: SizedBox(
          //         child: ListTile(
          //           contentPadding: const EdgeInsets.symmetric(
          //               horizontal: 20.0, vertical: 10.0),
          //           leading: const Icon(Icons.account_circle),
          //           title: Text(element['name']),
          //           trailing: const Icon(Icons.arrow_forward),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ));
  }
}
