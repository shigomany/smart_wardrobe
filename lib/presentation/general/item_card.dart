import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ItemCard extends StatelessWidget {
  final double widthScreen;
  const ItemCard({Key key, this.widthScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox.fromSize(
        child: Container(
          width: widthScreen / 2 - 24.w,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(119, 119, 119, 0.25),
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Color(0xFFF2F2F2), width: 1.w),
                ),
                width: widthScreen / 2 - 24.w,
                height: widthScreen / 2 - 24.w,
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'Образ #1',
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5,
                      fontWeight: FontWeight.w300,
                      color: CustomColors.textGrey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
