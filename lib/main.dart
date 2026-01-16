import 'package:flutter/material.dart';
import 'package:notes_app_sync/screens/editor_widget.dart';
void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EditorWidget(),
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
