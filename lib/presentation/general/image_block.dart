import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageBlock extends StatelessWidget {
  final double width;
  final Color color;
  final double borderRadius;

  const ImageBlock({Key key, this.width, this.color, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}
