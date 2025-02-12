import 'package:flutter/material.dart';
import 'package:constriturar/app/views/layouts/app_layout.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});
  final Widget child;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(child: widget.child);
  }
}
