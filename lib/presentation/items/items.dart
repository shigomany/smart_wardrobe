import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ext/list_ext.dart';
import 'package:quiver/iterables.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/general/bottom_bar.dart';
import 'package:smartwardrobe/presentation/general/card.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/bottom_dialog.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ItemsScreen extends StatefulWidget {
  static String routeName = '/kits';
  const ItemsScreen({Key key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class InheritedItemList extends InheritedWidget {
  final List<ViewClothing> data;
  InheritedItemList({
    Widget child,
    this.data,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedItemList oldWidget) =>
      data != oldWidget.data;
  static InheritedItemList of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedItemList>();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<Clothing> items = [];

  ClothingBloc _clothingBloc;

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
  void initState() {
    super.initState();

    _clothingBloc = BlocProvider.of<ClothingBloc>(context)
      ..add(FetchAllClothing());
  }

  @override
  void dispose() {
    items = [];
    super.dispose();
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

    return BlocConsumer<ClothingBloc, ClothingState>(
      listener: (context, state) {
        if (state is ClothesListLoaded) {
          items = state.clothing;
        }
      },
      builder: (context, state) {
        if (state is ClothingInitial) {
          return (Center(
            child: Text('empty'),
          ));
        }
        if (state is ClothingLoading) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        } else if (state is ClothesListLoaded) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                  child: (items?.countWhere((el) => el.isSelected) ?? -1) > 0
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
                          padding: EdgeInsets.symmetric(
                              vertical: 16.w, horizontal: 8.w),
                          child: Wrap(
                            children: [
                              for (var i in enumerate(
                                  items.map((e) => e.asViewClothing).toList()))
                                InheritedItemList(
                                  data: items
                                      .map((e) => e.asViewClothing)
                                      .toList(),
                                  child: ClothingCard(
                                      onChangeState: _onChangeState,
                                      onDeleteItem: _onDeleteItem,
                                      item: i,
                                      color: Color(
                                              (Random().nextDouble() * 0xFFFFFF)
                                                      .toInt() <<
                                                  0)
                                          .withOpacity(1.0)),
                                  // child: ItemWidget(
                                  //   onDeleteItem: _onDeleteItem,
                                  //   onChangeState: _onChangeState,
                                  //   item: i,
                                  //   color: Color(
                                  //           (Random().nextDouble() * 0xFFFFFF)
                                  //                   .toInt() <<
                                  //               0)
                                  //       .withOpacity(1.0),
                                  // ),
                                ),
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
              bottomNavigationBar: BottomBar(),
            ),
          );
        } else {
          return Center();
        }
      },
    );
  }
}

class InheritedItem extends InheritedWidget {
  final Clothing data;
  InheritedItem({
    Widget child,
    this.data,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedItem oldWidget) => data != oldWidget.data;
  static InheritedItem of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedItem>();
}

class ItemWidget extends StatefulWidget {
  final void Function(int) onChangeState;
  final void Function(int) onDeleteItem;
  final Color color;
  final IndexedValue<Clothing> item;
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
  Future navigateToItemScreen(context, Clothing item) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ItemScreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    final items = InheritedItemList.of(context).data.toList();
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;

    return GestureDetector(
      onTap: () {
        navigateToItemScreen(context, widget.item.value);
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
                        //color: widget.color,
                        border:
                            Border.all(color: Color(0xFFF2F2F2), width: 1.w),
                      ),
                      width: widthScreen / 2 - 24.w,
                      height: widthScreen / 2 - 24.w,
                      child: Image.network(
                        widget.item.value.imageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    if (widget.item.value.isSelected)
                      Container(
                        color: Colors.white70,
                        width: widthScreen / 2 - 24.w,
                        height: widthScreen / 2 - 24.w,
                        child: items.countWhere((el) => el.isSelected) > 1
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        onPressed: () => widget
                                            .onDeleteItem(widget.item.value.id),
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
                    '${widget.item.value.brand} ${widget.item.value.subCategory}'
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
