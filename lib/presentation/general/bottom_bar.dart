import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:smartwardrobe/presentation/items/items.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/resources/resources.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key, @required this.onTapItem}) : super(key: key);

  // Future navigateToScreen(context, routeLink) async {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => routeLink));
  // }

  final ValueChanged<int> onTapItem;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<BottomItem> _bottomItems = [];

  @override
  void initState() {
    super.initState();
    _bottomItems = [
      BottomItem(
        index: 0,
        padding: EdgeInsets.only(left: 16.w, top: 8.w, right: 8.w, bottom: 8.w),
        onTapItem: widget.onTapItem,
        asset: IconsPaths.clothes,
      ),
      BottomItem(
        index: 1,
        padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 32.w, bottom: 8.w),
        onTapItem: widget.onTapItem,
        asset: IconsPaths.kit,
      ),
      BottomItem(
        index: 2,
        padding: EdgeInsets.only(top: 8.w, left: 32.w, right: 8.w, bottom: 8.w),
        onTapItem: widget.onTapItem,
        asset: IconsPaths.settings,
      ),
      BottomItem(
        index: 3,
        padding: EdgeInsets.only(left: 8.w, top: 8.w, right: 16.w, bottom: 8.w),
        onTapItem: widget.onTapItem,
        asset: IconsPaths.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _bottomItems
            .map(
              (e) => e.isMainButton
                  ? Padding(
                      padding: e.padding,
                      child: SizedBox(
                        width: 36.w,
                        height: 36.w,
                        child: SvgPicture.asset(e.asset),
                      ),
                    )
                  : InkWell(
                      onTap: () => widget.onTapItem(e.index),
                      child: Padding(
                        padding: e.padding,
                        child: SizedBox(
                          width: 36.w,
                          height: 36.w,
                          child: SvgPicture.asset(e.asset),
                        ),
                      ),
                    ),
            )
            .toList(),
        // children: <Widget>[
        //   InkWell(
        //     onTap: () {
        // navigateToScreen(context, ItemsScreen());
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //           left: 16.w, top: 8.w, right: 8.w, bottom: 8.w),
        //       child: SizedBox(
        //         width: 36.w,
        //         height: 36.w,
        //         child: SvgPicture.asset(IconsPaths.clothes),
        //       ),
        //     ),
        //   ),
        //   GestureDetector(
        //     onTap: () {
        // navigateToScreen(context, ItemsScreen());
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //           top: 8.w, left: 8.w, right: 32.w, bottom: 8.w),
        //       child: SizedBox(
        //         width: 36.w,
        //         height: 36.w,
        //         child: SvgPicture.asset(IconsPaths.kit),
        //       ),
        //     ),
        //   ),
        //   Padding(
        //     padding:
        //         EdgeInsets.only(top: 8.w, left: 32.w, right: 8.w, bottom: 8.w),
        //     child: SizedBox(
        //       width: 36.w,
        //       height: 36.w,
        //       child: SvgPicture.asset(IconsPaths.settings),
        //     ),
        //   ),
        //   GestureDetector(
        //     onTap: () {
        //       navigateToScreen(context, MainScreen());
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //           left: 8.w, top: 8.w, right: 16.w, bottom: 8.w),
        //       child: SizedBox(
        //         width: 36.w,
        //         height: 36.w,
        //         child: SvgPicture.asset(IconsPaths.user),
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}

class BottomItem extends Equatable {
  const BottomItem({
    @required this.index,
    @required this.padding,
    @required this.onTapItem,
    @required this.asset,
    this.isMainButton = false,
  });

  final int index;
  final EdgeInsets padding;
  final ValueChanged<int> onTapItem;
  final String asset;
  final bool isMainButton;

  @override
  List<Object> get props => [index, padding, onTapItem, asset];

  @override
  bool get stringify => true;
}
