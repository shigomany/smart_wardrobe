import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiSelectChip extends StatefulWidget {
  final String title;
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  // MultiSelectChip(this.reportList, this.title, {this.onSelectionChanged});
  MultiSelectChip(
      {Key key, this.reportList, this.onSelectionChanged, this.title})
      : super(key: key);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = List();
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(top: 6.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.all(Radius.circular(6.w)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildChoiceList(),
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 12.sp, color: Color(0xFFB9B7B7)),
              ),
            ),
          ))
    ]);
  }
}
