// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:aednlaxer_blog/components/aednlaxerer.dart'
    deferred as _aednlaxerer;
import 'package:aednlaxer_blog/components/spoiler_toggle.dart'
    deferred as _spoiler_toggle;
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart'
    deferred as _code_block_copy_button;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'aednlaxerer': ClientLoader(
      (p) => _aednlaxerer.Aednlaxerer(value: p['value'] as String),
      loader: _aednlaxerer.loadLibrary,
    ),
    'spoiler_toggle': ClientLoader(
      (p) => _spoiler_toggle.SpoilerToggle(title: p['title'] as String),
      loader: _spoiler_toggle.loadLibrary,
    ),
    'jaspr_content:code_block_copy_button': ClientLoader(
      (p) => _code_block_copy_button.CodeBlockCopyButton(),
      loader: _code_block_copy_button.loadLibrary,
    ),
  },
);
