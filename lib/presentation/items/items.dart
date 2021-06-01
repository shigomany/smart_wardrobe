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
import 'package:smartwardrobe/presentation/general/clothing_card.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/bottom_dialog.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ItemsScreen extends StatefulWidget {
  static String routeName = '/kits';

  const ItemsScreen({
    Key key,
    @required this.selectedIndex,
    @required this.onTapNavigator,
  }) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onTapNavigator;

  @override
  _ItemsScreenState createState() => _ItemsScreenState();

  static _ItemsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_ItemsScreenState>();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<Clothing> items = [];

  void _onChangeState(int index) {
    setState(() {
      items[index].isSelected = !items[index].isSelected;
    });
  }

  void _onSelectedAll() {
    setState(() {
      for (var el in items) {
        el.isSelected = true;
      }
    });
  }

  void _onUnselectedAll() {
    setState(() {
      for (var el in items) {
        el.isSelected = false;
      }
    });
  }

  void _onDeleteSelected() {
    setState(() {
      items.removeWhere((el) => el.isSelected);
    });
  }

  //TODO : event в блоке на удаление
  void _onDeleteItem(int id) {
    setState(() {
      items.removeWhere((el) => el.id == id);
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClothingBloc>(context)..add(FetchAllClothing());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            child: (items?.countWhere((el) => el.isSelected) ?? -1) > 0
                ? AppBarWithCounter(
                    onSelectedAll: () => _onSelectedAll(),
                    onUnselectedAll: () => _onUnselectedAll(),
                    onDeleteSelected: () => _onDeleteSelected(),
                    items: items)
                : LogoBar(title: "Мои вещи")),
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
                    child: BlocConsumer<ClothingBloc, ClothingState>(
                      listener: (context, state) {
                        if (state is ClothesListLoaded) {
                          items = state.clothingList;
                        }
                      },
                      builder: (context, state) {
                        if (state is ClothesListLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            ),
                          );
                        } else if (state is ClothesListLoaded) {
                          return Wrap(
                            children: [
                              // for (var i in enumerate(
                              //     items.map((e) => e.asViewClothing).toList()))
                              for (var i in enumerate(items))
                                ClothingCard(
                                    onChangeState: _onChangeState,
                                    onDeleteItem: _onDeleteItem,
                                    item: i)
                            ],
                          );
                        } else {
                          print(state);
                          return Center(
                              child: Text(
                            "No data was received",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w300),
                          ));
                        }
                      },
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(
          onTapItem: widget.onTapNavigator,
        ),
      ),
    );
  }
}

typedef void VoidCallback();

class AppBarWithCounter extends StatelessWidget {
  final VoidCallback onSelectedAll;
  final VoidCallback onUnselectedAll;
  final VoidCallback onDeleteSelected;
  final List<Clothing> items;

  const AppBarWithCounter({
    Key key,
    this.onSelectedAll,
    this.onUnselectedAll,
    this.items,
    this.onDeleteSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                onUnselectedAll();
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
              onSelectedAll();
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
            onPressed: () async {
              bool deletingDialog = await showAlertDialog(context) ?? false;
              if (deletingDialog) onDeleteSelected();
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
    );
  }
}

showAlertDialog(BuildContext context) async {
  Widget cancelButton = TextButton(
    child: Text("Отмена"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Удалить"),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );
  return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Удалить образы"),
            content: Text("Вы точно хотите удалить выбранные образы?"),
            actions: [
              cancelButton,
              continueButton,
            ]);
      });
}
