import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiSelectChipGroup extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(List<String>) onSelectionChanged;
  final List<IconData> leftIcons;
  final Color selectedColor;
  final Color disabledColor;
  final Color labelSelectedColor;
  final Color labelDisabledColor;
  final Color iconDisabledColor;
  final Color iconSelectedColor;
  final IconData leftCommonIcon;
  final double leftIconSize;
  final EdgeInsetsGeometry padding;
  final double labelFontSize;
  final WrapAlignment alignment;
  final double horizontalChipSpacing;
  final double verticalChipSpacing;
  final List<String> preSelectedItems;
  final bool isSelectionAllowed;
  MultiSelectChipGroup(
      {@required this.title,
      @required this.items,
      @required this.selectedColor,
      @required this.disabledColor,
      this.isSelectionAllowed = true,
      this.onSelectionChanged,
      this.labelSelectedColor,
      this.labelDisabledColor,
      this.leftCommonIcon,
      this.padding,
      this.labelFontSize,
      this.leftIconSize,
      this.iconDisabledColor,
      this.iconSelectedColor,
      this.leftIcons,
      this.horizontalChipSpacing,
      this.verticalChipSpacing,
      this.preSelectedItems,
      this.alignment})
      : assert(isSelectionAllowed != null);
  @override
  _MultiSelectChipGroupState createState() =>
      _MultiSelectChipGroupState(preSelectedItems, onSelectionChanged);
}

class _MultiSelectChipGroupState extends State<MultiSelectChipGroup> {
  List<String> selectedChoices = [];
  _MultiSelectChipGroupState(List<String> preSelectedItems,
      Function(List<String>) onSelectionChanged) {
    if (preSelectedItems != null) {
      selectedChoices = preSelectedItems;
      if (onSelectionChanged != null) onSelectionChanged(selectedChoices);
    }
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> choiceChips = [];
    widget.items.asMap().forEach((index, item) {
      choiceChips.add(choiceChip(item,
          leftIcon: widget.leftIcons != null ? widget.leftIcons[index] : null));
    });
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFF2F2F2)),
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: widget.horizontalChipSpacing == null
                      ? 0
                      : widget.horizontalChipSpacing,
                  runSpacing: widget.verticalChipSpacing == null
                      ? 0
                      : widget.verticalChipSpacing,
                  alignment: widget.alignment == null
                      ? WrapAlignment.center
                      : widget.alignment,
                  children: choiceChips,
                ),
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
      ],
    );
  }

  Widget choiceChip(String item, {IconData leftIcon}) {
    return ChoiceChip(
      labelStyle: TextStyle(
          fontSize: widget.labelFontSize == null ? 14.sp : widget.labelFontSize,
          color: selectedChoices.contains(item)
              ? widget.labelSelectedColor == null
                  ? widget.disabledColor
                  : widget.labelSelectedColor
              : widget.labelDisabledColor == null
                  ? widget.selectedColor
                  : widget.labelDisabledColor),
      selectedColor: widget.selectedColor,
      disabledColor: widget.disabledColor,
      backgroundColor: widget.disabledColor,
      labelPadding: widget.padding,
      padding: widget.padding,
      avatar: widget.leftCommonIcon == null && leftIcon == null
          ? null
          : Icon(
              leftIcon == null ? widget.leftCommonIcon : leftIcon,
              color: selectedChoices.contains(item)
                  ? widget.iconSelectedColor == null
                      ? widget.disabledColor
                      : widget.iconSelectedColor
                  : widget.iconDisabledColor == null
                      ? widget.selectedColor
                      : widget.iconDisabledColor,
              size: widget.leftIconSize == null ? 16 : widget.leftIconSize,
            ),
      label: Text(item, style: TextStyle(color: Colors.black)),
      selected: selectedChoices.contains(item) ? true : false,
      onSelected: (selected) {
        setState(() {
          selectedChoices.contains(item)
              ? selectedChoices.remove(item)
              : selectedChoices.add(item);
          if (widget.onSelectionChanged != null)
            widget.onSelectionChanged(selectedChoices); // +added
        });
      },
    );
  }
}
