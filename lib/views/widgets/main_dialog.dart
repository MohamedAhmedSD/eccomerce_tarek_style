import 'package:flutter/material.dart';

//? how we build alert dialog ?
//* we make class not extends from stf or stl
//* then we make function inside it to use its attributes to build our function
class MainDialog {
  //! it need => BuildContect,List,String
  final BuildContext context; //? BuildContext => showDialog need it
  final String title;
  final String content;
  //? its List of Widget !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //! compose from Map => String && function == Widget
  final List<Map<String, void Function()?>>? actions;

  MainDialog({
    required this.context,
    required this.title,
    required this.content,
    this.actions,
  });

  //* how it build? => [ F -> F -> W ]
  showAlertDialog() {
    //! our function call built-in function => showDialog
    showDialog(
        //* it required both context & builder
        context: context,
        builder: (_) => AlertDialog(
              //! it return a widget Typically used in conjunction with [showDialog].
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content: Text(
                content,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              //* The (optional) set of actions that are displayed at the bottom
              //* of the dialog with an [OverflowBar].
              //! {List<Widget>? actions}

              //? if list not empty make btns that display
              //? its keys as text, and values as (F) on => onPressed part
              actions: (actions != null)
                  ? actions!
                      .map((action) => TextButton(
                            onPressed: action.values.first,
                            child: Text(action.keys.first),
                          ))
                      .toList()
                  :
                  //! or back a list of one btn, display OK
                  //? and its F => Nav..pop => out from dialog when pressed
                  [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
            ));
  }
}
