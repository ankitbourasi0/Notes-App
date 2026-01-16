// import 'dart:convert';
// import 'dart:io' as io show Directory, File;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
//
// import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
// import 'package:path/path.dart' as path;
//
// class NoteWidget extends StatefulWidget {
//   const NoteWidget({super.key});
//
//   @override
//   State<NoteWidget> createState() => _NoteWidgetState();
// }
//
// class _NoteWidgetState extends State<NoteWidget> {
//   final QuillController _controller = QuillController.basic(
//       config: QuillControllerConfig(
//           clipboardConfig: QuillClipboardConfig(
//               enableExternalRichPaste: true,
//               onImagePaste: (imageBytes) async {
//                 if (kIsWeb) {
//                   //Dart IO is unsupported on web
//                   return null;
//                 }
//                 //Save the image somewhere and return the image URL that will be
//                 // stored in Quill Delta JSON(the document).
//                 final newFileName =
//                     'image-file-${DateTime.now().toIso8601String()}.png';
//                 final newPath =
//                     path.join(io.Directory.systemTemp.path, newFileName);
//                 final file = await io.File(
//                   newPath,
//                 ).writeAsBytes(imageBytes, flush: true);
//                 return file.path;
//               })));
//
//
//   final FocusNode _editorFocusNode = FocusNode();
//   final ScrollController _editorScrollController = ScrollController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller.document = Document.fromJson(kQuillDefaultSample);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Quill Example"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content:
//                     Text('The JSON Delta has been printed to the console.'),
//               ));
//               debugPrint(jsonEncode(_controller.document.toDelta().toJson()));
//             },
//             icon: const Icon(Icons.output),
//             tooltip: 'Print Delta JSON to log',
//           )
//         ],
//       ),
//       body: SafeArea(
//           child: Column(
//         children: [
//           QuillSimpleToolbar(
//             controller: _controller,
//           ),
//           Expanded(
//             child: QuillEditor(
//               focusNode: _editorFocusNode,
//               scrollController: _editorScrollController,
//               controller: _controller,
//               config: QuillEditorConfig(
//                   placeholder: 'Start writing your notes',
//                   padding: EdgeInsets.all(16),
//                   embedBuilders: [
//                     ...FlutterQuillEmbeds.editorBuilders(imageEmbedConfig:
//                         QuillEditorImageEmbedConfig(
//                             imageProviderBuilder: (context, imageUrl) {
//                       // https://pub.dev/packages/flutter_quill_extensions#-image-assets
//                       if (imageUrl.startsWith('assets/')) {
//                         return AssetImage(imageUrl);
//                       }
//                       return null;
//                     }), videoEmbedConfig: QuillEditorVideoEmbedConfig(
//                         customVideoBuilder: (videoUrl, readOnly) {
//                       // To load YouTube videos https://github.com/singerdmx/flutter-quill/releases/tag/v10.8.0
//                       return null;
//                     })),
//                     TimeStampEmbedBuilder()
//                   ]),
//             ),
//           )
//         ],
//       )),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _editorScrollController.dispose();
//     _editorFocusNode.dispose();
//     super.dispose();
//   }
// }
//
// class TimeStampEmbed extends Embeddable {
//   const TimeStampEmbed(
//     String value,
//   ) : super(timeStampType, value);
//   static const String timeStampType = 'timeStamp';
//
//   static TimeStampEmbed fromDocument(Document document) =>
//       TimeStampEmbed(jsonEncode(document.toDelta().toJson()));
//   Document get document => Document.fromJson(jsonDecode(data));
// }
//
// class TimeStampEmbedBuilder extends EmbedBuilder {
//   @override
//   String get key => 'timeStamp';
//
//   @override
//   String toPlainText(Embed node) {
//     return node.value.data;
//   }
//
//   @override
//   Widget build(BuildContext context, EmbedContext embedContext) {
//     return Row(
//       children: [
//         Icon(Icons.access_time_rounded),
//         Text(embedContext.node.value.data as String)
//       ],
//     );
//   }
// }
