import 'package:flutter/material.dart';
import '../view/other_screen/to_do_list_screen.dart';

final Map<String, WidgetBuilder> routes = {
  TodoListScreen.routeName: (context) => const TodoListScreen(),
};
