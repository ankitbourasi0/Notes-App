import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({super.key});

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  EditorState? _editorState;
  late final EditorScrollController editorScrollController;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    try {
      //load the json as a string
      final String jsonString =
          await rootBundle.loadString('assets/document/desktop.json');
      //decode the json string
      final Map<String, dynamic> jsonData =
          jsonDecode(jsonString) as Map<String, dynamic>;
      print(jsonData);

      setState(() {
        _editorState = EditorState(document: Document.fromJson(jsonData));
        editorScrollController = editorScrollController =
            EditorScrollController(
                editorState: _editorState!, shrinkWrap: false);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading journal data $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _editorState == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return FloatingToolbar(
        items: [
          paragraphItem,
          ...headingItems,
          ...markdownFormatItems,
          quoteItem,
          bulletedListItem,
          numberedListItem,
          linkItem,
          ...textDirectionItems,
          ...alignmentItems,
        ],
        tooltipBuilder: (context, id, message, child) {
          return Tooltip(
            message: message,
            child: child,
            preferBelow: false,
          );
        },
        editorState: _editorState!,
        editorScrollController: editorScrollController,
        textDirection: TextDirection.ltr,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: AppFlowyEditor(
              editorState: _editorState!,
              editorScrollController: editorScrollController,
            )));
  }
}
