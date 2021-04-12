import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ext/list_ext.dart';
import 'package:quiver/iterables.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import 'package:smartwardrobe/domain/model/clothing_image.dart';
import 'package:smartwardrobe/presentation/general/bottom_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/bottom_dialog.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class KitsScreen extends StatefulWidget {
  static String routeName = '/kits';
  const KitsScreen({Key key}) : super(key: key);

  @override
  _KitsScreenState createState() => _KitsScreenState();
}

class _KitsScreenState extends State<KitsScreen> {
  final List<ClothingImage> items = [
    ClothingImage(id: 1),
    ClothingImage(id: 21),
    ClothingImage(id: 13),
    ClothingImage(id: 7),
    ClothingImage(id: 25),
    ClothingImage(id: 47),
    ClothingImage(id: 2),
    ClothingImage(id: 66),
  ];

  void _onChangeState(int index) {
    setState(() {
      items[index].isSelected = !items[index].isSelected;
    });
  }

  void _onEditItem() {}

  void _onDeleteItem(int id) {
    setState(() {
      items.removeWhere((el) => el.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Отмена"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Удалить"),
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            items.removeWhere((el) => el.isSelected);
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Удалить образы"),
        content: Text("Вы точно хотите удалить выбранные образы?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
              child: items.countWhere((el) => el.isSelected) > 0
                  ? AppBar(
                      leading: Builder(builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: IconButton(
                              icon: Icon(
                                Entypo.cross,
                                color: Colors.black,
                                size: 24.sp,
                              ),
                              onPressed: () {
                                setState(() {
                                  for (var el in items) {
                                    el.isSelected = false;
                                  }
                                });
                              }),
                        );
                      }),
                      centerTitle: true,
                      title: Text(
                        'Выбрано: ${items.countWhere((el) => el.isSelected)}',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                for (var el in items) {
                                  el.isSelected = true;
                                }
                              });
                            },
                            icon: Icon(
                              MaterialCommunityIcons.select_all,
                              color: Colors.black,
                              size: 24.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: IconButton(
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 24.sp,
                            ),
                          ),
                        )
                      ],
                      backgroundColor: Colors.white,
                    )
                  : LogoBar(title: "Мои комплекты")),
          body: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16.w, horizontal: 8.w),
                      child: Wrap(
                        children: [
                          for (var i in enumerate(items))
                            ItemWidget(
                              onDeleteItem: _onDeleteItem,
                              onChangeState: _onChangeState,
                              item: i,
                              color: Color((Random().nextDouble() * 0xFFFFFF)
                                          .toInt() <<
                                      0)
                                  .withOpacity(1.0),
                            )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 2,
            onPressed: () {
              YYBottomSheetDialog(context);
            },
            child: Icon(Icons.add,
                color: Color.fromRGBO(253, 253, 253, 1), size: 36.sp),
            backgroundColor: CustomColors.textPrimaryLight,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomBar()),
    );
  }
}

///
/// Simple Widget to demonstrate the use
/// of the OverlayableContainerOnLongPress
///
class ItemWidget extends StatefulWidget {
  // final ValueChanged<int> onChange;
  final void Function(int) onChangeState;
  final void Function(int) onDeleteItem;
  final Color color;
  final IndexedValue<ClothingImage> item;
  ItemWidget({
    Key key,
    this.onChangeState,
    this.onDeleteItem,
    this.color,
    this.item,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Future navigateToItemsScreen(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;

    return GestureDetector(
      onTap: () {
        navigateToItemsScreen(context);
      },
      onLongPress: () {
        setState(() {
          widget.onChangeState(widget.item.index);
          print(widget.item.value);
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
                        color: widget.color,
                        border:
                            Border.all(color: Color(0xFFF2F2F2), width: 1.w),
                      ),
                      width: widthScreen / 2 - 24.w,
                      height: widthScreen / 2 - 24.w,
                    ),
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
                      )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    'Образ #${widget.item.value.id}',
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
      ),
    );
  }

  void _onEditItem() {
    print('edit item: ${widget.item}');
  }

  void _onDeleteItem() {}
}

showAlertDialog(BuildContext context) {
// set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Удалить образы"),
    content: Text("Вы точно хотите удалить образы?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
