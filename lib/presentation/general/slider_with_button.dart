import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/presentation/general/image_slider.dart';

class SliderWithButton extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String buttonText;
  final String buttonLink;
  final Color buttonTextColor;
  final Color backgroundColor;
  const SliderWithButton(
      {Key key,
      this.title,
      this.buttonText,
      this.buttonLink,
      this.backgroundColor,
      this.titleColor,
      this.buttonTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w300,
                      color: titleColor)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
              child: Container(
                height: 120.w,
                child: ImageSlider(itemsCount: 4),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.w, left: 16.w, right: 16.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFf2f2f2)),
                            borderRadius: BorderRadius.circular(5.w))),
                    onPressed: () {
                      print(buttonLink);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            color: buttonTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
