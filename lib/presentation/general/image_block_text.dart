import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/presentation/general/image_block.dart';

class ImageBlockText extends StatelessWidget {
  final double width;
  final Color color;
  final double borderRadius;

  const ImageBlockText({Key key, this.width, this.color, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.w),
          child: Text(
            'Text',
            style: TextStyle(
                color: Color(0xFF696767),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
      ],
    );
  }
}
