import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final List<String> items;
  final void Function(String? value) onChanged;
  final String hint;
  const DropDownMenuComponent({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hint,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      hint: Text(hint),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
