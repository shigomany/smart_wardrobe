import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/presentation/general/editable_expansion_tile.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ListMenuSlider extends StatefulWidget {
  ListMenuSlider({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListMenuSliderState createState() => _ListMenuSliderState();
}

class _ListMenuSliderState extends State<ListMenuSlider>
    with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;
  Animatable<double> _arrowAnimationAnimatiable;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi / 2).animate(_arrowAnimationController);
    _arrowAnimationAnimatiable = Tween<double>(begin: 0.0, end: 0.25);
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EditableExpansionTile(
      animatedWidgetTurnTween: _arrowAnimationAnimatiable,
      bottomBorderOn: true,
      borderColorEnd: Color(0xFFEDEDED),
      borderColorStart: Color(0xFFEDEDED),
      kExpand: const Duration(milliseconds: 400),
      animatedWidgetFollowingHeader: Icon(
        MaterialIcons.keyboard_arrow_right,
        size: 48.sp,
      ),
      header: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 16.w, top: 16.w, right: 8.w, bottom: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w)),
                            border: Border.all(color: Color(0xFFEDEDED)),
                          ))),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: CustomColors.textDark,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFEDEDED),
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                "По фотографии",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFEDEDED),
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                "По ссылке",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFEDEDED),
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                "По описанию",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        )
      ],
    );
  }
}
