// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:aednlaxer_blog/components/aednlaxerer.dart' as _aednlaxerer;
import 'package:aednlaxer_blog/components/spoiler.dart' as _spoiler;
import 'package:aednlaxer_blog/components/spoiler_toggle.dart'
    as _spoiler_toggle;
import 'package:aednlaxer_blog/main.server.dart' as _main$server;
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart'
    as _code_block_copy_button;
import 'package:jaspr_content/components/code_block.dart' as _code_block;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _aednlaxerer.Aednlaxerer: ClientTarget<_aednlaxerer.Aednlaxerer>(
      'aednlaxerer',
      params: __aednlaxererAednlaxerer,
    ),
    _spoiler_toggle.SpoilerToggle: ClientTarget<_spoiler_toggle.SpoilerToggle>(
      'spoiler_toggle',
      params: __spoiler_toggleSpoilerToggle,
    ),
    _code_block_copy_button.CodeBlockCopyButton:
        ClientTarget<_code_block_copy_button.CodeBlockCopyButton>(
          'jaspr_content:code_block_copy_button',
        ),
  },
  styles: () => [
    ..._main$server.styles,
    ..._spoiler.Spoiler.styles,
    ..._code_block.CodeBlock.styles,
  ],
);

Map<String, Object?> __aednlaxererAednlaxerer(_aednlaxerer.Aednlaxerer c) => {
  'value': c.value,
};
Map<String, Object?> __spoiler_toggleSpoilerToggle(
  _spoiler_toggle.SpoilerToggle c,
) => {'title': c.title};
