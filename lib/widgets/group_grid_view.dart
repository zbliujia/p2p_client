import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GroupGridView extends CustomScrollView {
  const GroupGridView({super.key,
    required this.gridDelegate,
    required this.sectionCount,
    required this.itemInSectionBuilder,
    required this.itemInSectionCount,
    this.headerForSection,
    this.footerForSection,
    super.scrollDirection = Axis.vertical,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap = false,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlive = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior = DragStartBehavior.start,
    super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.restorationId,
    super.clipBehavior = Clip.hardEdge,
  }) : super();

  final SliverGridDelegate gridDelegate;
  final int sectionCount;
  final Widget Function(BuildContext context, IndexPath indexPath)
      itemInSectionBuilder;
  final int Function(int section) itemInSectionCount;

  final Widget? Function(int section)? headerForSection;
  final Widget? Function(int section)? footerForSection;

  final IndexPath? Function(Key)? findChildIndexCallback;
  final bool addAutomaticKeepAlive;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  List<Widget> get _listSliver {
    List<Widget> list = [];
    for (var section = 0; section < sectionCount; section++) {
      final header = headerForSection?.call(section);
      if (header != null) {
        list.add(SliverToBoxAdapter(child: header));
      }

      list.add(SliverGrid.builder(
          addAutomaticKeepAlives: addAutomaticKeepAlive,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          gridDelegate: gridDelegate,
          itemBuilder: (context, index) => itemInSectionBuilder.call(
              context, IndexPath(section: section, index: index)),
          itemCount: itemInSectionCount.call(section)));

      final footer = footerForSection?.call(section);
      if (footer != null) {
        list.add(SliverToBoxAdapter(child: footer));
      }
    }
    return list;
  }

  @override
  List<Widget> buildSlivers(BuildContext context) {
    return _listSliver;
  }

}

class IndexPath {
  const IndexPath({required this.section, required this.index});

  final int section;
  final int index;
}
