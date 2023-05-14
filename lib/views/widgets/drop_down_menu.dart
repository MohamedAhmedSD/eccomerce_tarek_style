import 'package:flutter/material.dart';

import '../../utilities/dimenssions.dart';

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
    // return DropdownButtonFormField<String>(
    return Container(
      height: AppMediaQuery.getHeight(context, 30),
      width: AppMediaQuery.getWidth(context, 130),
      //! cann't use both decoration && null on same time
      // color: Colors.white,
      decoration: BoxDecoration(
          border: Border.all(
              width: AppMediaQuery.getWidth(context, 1), color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.getHeight(context, 8),
        ),
        child: DropdownButton<String>(
          menuMaxHeight:
              100, //! used to set max highest when opening menu of items
          value: null,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true, //! we need it to move icon into end of menu
          // decoration: const InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //       borderSide: BorderSide(width: 1, color: Colors.grey),
          //     ),
          //     filled: true,
          //     fillColor: Colors.white),

          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppMediaQuery.getHeight(context, 12)),

          //* Creates a widget that scales and positions its child within itself according to [fit].
          hint: SizedBox(
            child: Text(
              hint,
              style: TextStyle(
                  fontSize: AppMediaQuery.getHeight(context, 12),
                  fontWeight: FontWeight.bold),
            ),
          ),
          onChanged: onChanged,
          elevation: 8,
          //! to delete line that appear under the button
          underline: Container(
            color: Colors.transparent,
          ),
          //! how we use it =========================
          // itemHeight: 20,
          //* The current elements of this iterable modified by [toElement].
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), //! ## don't forget back them into list ##
        ),
      ),
    );
  }
}

      //!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!
      //? did we talk about sizes => M,S...




