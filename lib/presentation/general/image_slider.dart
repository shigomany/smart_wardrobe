import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatelessWidget {
  final int itemsCount;
  const ImageSlider({Key key, this.itemsCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsCount,
      itemBuilder: (context, index) {
        return new Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFF2F2F2)),
                  borderRadius: BorderRadius.all(Radius.circular(4.w)),
                )));
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
