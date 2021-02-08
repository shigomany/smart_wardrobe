import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/presentation/general/image_block.dart';

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
          child: ImageBlock(
            color: Colors.white,
            borderRadius: 4.w,
            width: 120.w,
          ),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
