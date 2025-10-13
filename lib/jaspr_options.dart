// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:aednlaxer_blog/components/aednlaxerer.dart' as prefix0;
import 'package:aednlaxer_blog/components/spoiler.dart' as prefix1;
import 'package:aednlaxer_blog/components/spoiler_toggle.dart' as prefix2;
import 'package:aednlaxer_blog/main.dart' as prefix3;
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart'
    as prefix4;
import 'package:jaspr_content/components/code_block.dart' as prefix5;

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

    prefix2.SpoilerToggle: ClientTarget<prefix2.SpoilerToggle>(
      'components/spoiler_toggle',
      params: _prefix2SpoilerToggle,
    ),

    prefix4.CodeBlockCopyButton: ClientTarget<prefix4.CodeBlockCopyButton>(
      'jaspr_content:components/_internal/code_block_copy_button',
    ),
  },
  styles: () => [
    ...prefix1.Spoiler.styles,
    ...prefix3.styles,

    ...prefix5.CodeBlock.styles,
  ],
);

Map<String, dynamic> _prefix0Aednlaxerer(prefix0.Aednlaxerer c) => {
  'value': c.value,
};
Map<String, dynamic> _prefix2SpoilerToggle(prefix2.SpoilerToggle c) => {
  'title': c.title,
};
