import 'package:flutter/material.dart';

import 'FilterButton.dart';

class FilterBar extends StatefulWidget {
  const FilterBar(
      {Key? key, required this.menuItems, required this.onSelectionChanged})
      : super(key: key);

  final List<String> menuItems;
  final Function(List<bool>) onSelectionChanged;

  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  List<bool> _selections = [];

  @override
  void initState() {
    super.initState();

    _selections = List.generate(widget.menuItems.length, (_) => false);
    if (_selections.isNotEmpty) {
      _selections[0] = true;
    }
  }

  onButtonClicked(int index) {
    if (_selections[index] == true) {
      return;
    }
    setState(() {
      _selections = List.generate(widget.menuItems.length, (_) => false);
      _selections[index] = true;
    });
    widget.onSelectionChanged(_selections);
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
        maxWidth: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                      widget.menuItems.length,
                      (index) => FilterButton(
                            text: widget.menuItems[index],
                            isSelected: _selections[index],
                            onPressed: () {
                              onButtonClicked(index);
                            },
                          ))
                  .expand((button) => [
                        button,
                        const SizedBox(
                          width: 15,
                        )
                      ])
                  .toList()),
        ));
  }
}
