// // lib\src\editor\block_component\quote_block_component\quote_block_component.dart
// import 'package:appflowy_editor/appflowy_editor.dart';

// class QuoteBlockKeys {
//   const QuoteBlockKeys._();
//   static const String type = 'quote';
//   static const String delta = blockComponentDelta;
//   static const String backgroundColor = blockComponentBackgroundColor;
//   static const String textDirection = blockComponentTextDirection;
// }

// Node quoteNode({
//   Delta? delta,
//   String? textDirection,
//   Attributes? attributes,
//   Iterable<Node>? children,
// }) {
//   attributes ??= {'delta': (delta ?? Delta()).toJson()};
//   return Node(
//     type: QuoteBlockKeys.type,
//     attributes: {
//       ...attributes,
//       if (textDirection != null) QuoteBlockKeys.textDirection: textDirection,
//     },
//     children: children ?? [],
//   );
// }

// class QuoteBlockComponentBuilder extends BlockComponentBuilder {
//   QuoteBlockComponentBuilder({
//     this.configuration = const BlockComponentConfiguration(),
//     this.iconBuilder,
//   });

//   @override
//   final BlockComponentConfiguration configuration;

//   final BlockIconBuilder ? iconBuilder;

//   @override
//   BlockComponentWidget build(BlockComponentContext blockComponentContext) {
//     final node = blockComponentContext.node;
//     return QuoteBlockComponentWidget(
//       key: node.key,
//       node: node,
//       configuration: configuration,
//       iconBuilder: iconBuilder,
//       showActions: showActions(node),
//       actionBuilder: (context, state) => actionBuilder(
//         blockComponentContext,
//         state,
//       ),
//     );
//   }

//   @override
//   bool validate(Node node) => node.delta != null;
// }