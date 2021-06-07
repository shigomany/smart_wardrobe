import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiver/iterables.dart';

import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/set.dart';
import 'package:smartwardrobe/presentation/edit_item/edit_item.dart';
import 'package:smartwardrobe/presentation/general/bottom_bar.dart';
import 'package:smartwardrobe/presentation/general/bottom_dialog.dart';
import 'package:smartwardrobe/presentation/general/clothing_card.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/item_card.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemScreen extends StatefulWidget {
  static String routeName = '/item';
  final Clothing item;
  const ItemScreen({Key key, this.item}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Set> sets;
  //Clothing item;

  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  Future navigateToEditScreen(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditItemScreen(clothing: widget.item)));
  }

  @override
  void initState() {
    BlocProvider.of<SetBloc>(context)..add(FetchRelatedSets(1));
    //BlocProvider.of<ClothingBloc>(context)..add(FetchClothingById(id: 1));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    YYDialog.init(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(119, 119, 119, 0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 8.w, right: 16.w, bottom: 8.w, left: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          navigateBack(context);
                        },
                        child: Row(
                          children: [
                            Icon(MaterialIcons.keyboard_arrow_left,
                                size: 36.sp, color: CustomColors.textDark),
                            Text('Вещь',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: CustomColors.textDark)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToEditScreen(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Icon(
                          MaterialCommunityIcons.pencil,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    Icon(
                      MaterialCommunityIcons.trash_can,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(119, 119, 119, 0.25),
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 328.w,
                              height: 328.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFF2F2F2), width: 4.w),
                              ),
                              child: Image.network(widget.item.imageUrl,
                                  fit: BoxFit.scaleDown),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.item.brand.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Text(widget.item.subCategory.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.sp,
                                          height: 1.5)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              119, 119, 119, 0.25),
                                          blurRadius: 7,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Размер',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF696767)),
                                      ),
                                      Text(widget.item.size,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w300,
                                              height: 1.5))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () => _launchURL(widget.item.url),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              119, 119, 119, 0.25),
                                          blurRadius: 7,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'URL вещи в магазине',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF696767)),
                                      ),
                                      Text(
                                          widget.item.url
                                              .replaceAll("", "\u{200B}"),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w300,
                                              height: 1.5))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFf2f2f2)),
                                borderRadius: BorderRadius.circular(5.w))),
                        onPressed: () {
                          print('Составить образ с вещью');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          child: Text(
                            'Составить образ с вещью',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Text(
                      'Комплекты с этой вещью',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w300),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
                  child: BlocConsumer<SetBloc, SetState>(
                    listener: (context, state) {
                      if (state is SetsListLoaded) {
                        sets = state.sets;
                      }
                    },
                    builder: (context, state) {
                      if (state is SetInitial) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          ),
                        );
                      } else if (state is SetLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          ),
                        );
                      } else if (state is SetsListLoaded) {
                        //TODO: карточки для сетов
                        // return Wrap(
                        //   children: [
                        //     for (var i in enumerate(
                        //         sets))
                        //       ClothingCard(
                        //           onChangeState: (int i) {},
                        //           onDeleteItem: (int i) {},
                        //           item: i)
                        //   ],
                        // );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bottomAddMenu(context);
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
