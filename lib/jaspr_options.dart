// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:aednlaxer_blog/components/aednlaxerer.dart' as prefix0;
import 'package:aednlaxer_blog/main.dart' as prefix1;
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart'
    as prefix2;
import 'package:jaspr_content/components/code_block.dart' as prefix3;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix0.Aednlaxerer: ClientTarget<prefix0.Aednlaxerer>(
      'components/aednlaxerer',
      params: _prefix0Aednlaxerer,
    ),

    prefix2.CodeBlockCopyButton: ClientTarget<prefix2.CodeBlockCopyButton>(
      'jaspr_content:components/_internal/code_block_copy_button',
    ),
  },
  styles: () => [...prefix1.styles, ...prefix3.CodeBlock.styles],
);

Map<String, dynamic> _prefix0Aednlaxerer(prefix0.Aednlaxerer c) => {
  'value': c.value,
};
