import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothingCard extends StatefulWidget {
  final void Function(int) onChangeState;
  final void Function(int) onDeleteItem;
  final IndexedValue<Clothing> item;
  ClothingCard({Key key, this.onChangeState, this.onDeleteItem, this.item})
      : super(key: key);

  @override
  _ClothingCardState createState() => _ClothingCardState();
}

class _ClothingCardState extends State<ClothingCard> {
  Image img;
  @override
  void initState() {
    _initImg();

    super.initState();
  }

  _initImg() async {
    File(widget.item.value.imageUrl).exists().then((value) {
      if (value) {
        setState(() {
          img = Image.file(File(widget.item.value.imageUrl),
              fit: BoxFit.scaleDown);
        });
      } else {
        setState(() {
          img = Image.network(
            widget.item.value.imageUrl,
            fit: BoxFit.scaleDown,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemScreen(item: widget.item.value)));
      },
      onLongPress: () {
        setState(() {
          widget.onChangeState(widget.item.index);
        });
      },
      child: Padding(
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
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFF2F2F2), width: 1.w),
                        ),
                        width: widthScreen / 2 - 24.w,
                        height: widthScreen / 2 - 24.w,
                        child: img),
                    if (widget.item.value.isSelected)
                      Container(
                        color: Colors.white70,
                        width: widthScreen / 2 - 24.w,
                        height: widthScreen / 2 - 24.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: SizedBox.expand(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _onEditItem();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox.expand(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                      widget.onDeleteItem(widget.item.value.id),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    (widget.item.value.brand.name +
                            ' ' +
                            widget.item.value.subCategory.name)
                        .replaceAll("", "\u{200B}"),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
      ),
    );
  }

  void _onEditItem() {
    print('edit item: ${widget.item}');
  }

  void _onDeleteItem() {}
}
