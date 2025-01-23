// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class SelectedCategories extends StatefulWidget {
  Function(List<String>) onCategoriesSelected;
  SelectedCategories({
    super.key,
    required this.onCategoriesSelected,
  });

  @override
  _SelectedCategoriesState createState() => _SelectedCategoriesState();
}

class _SelectedCategoriesState extends State<SelectedCategories> {
  final List<String> allCategories = [
    'Sofas',
    'Chairs',
    'Tables',
    'Beds',
    'Cabinets',
    'Others',
  ];

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("SelectedCategories$selectedCategories");
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: 50,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: allCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                label: Text(
                  category,
                  style: const TextStyle(),
                ),
                selected: selectedCategories.contains(category),
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).canvasColor,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(category);
                    } else {
                      selectedCategories.remove(category);
                    }
                  });
                  widget.onCategoriesSelected(selectedCategories);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
