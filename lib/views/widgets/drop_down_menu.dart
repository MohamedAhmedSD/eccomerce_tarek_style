import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final void Function(String? value) onChanged;
  final List<String> items; //! we work on this list
  final String hint;
  const DropDownMenuComponent({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Creates a [DropdownButton] widget that is a [FormField], wrapped in an [InputDecorator].
    return DropdownButtonFormField<String>(
      value: null,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      elevation: 16,
      style: Theme.of(context).textTheme.headlineSmall,

      //* Creates a widget that scales and positions its child within itself according to [fit].
      hint: FittedBox(
        child: Text(hint),
      ),
      onChanged: onChanged,

      //* The current elements of this iterable modified by [toElement].
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(), //! ## don't forget back them into list ##
    );
  }
}

      //!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!
      //? did we talk about sizes => M,S...

