import 'package:aednlaxer_blog/components/spoiler_toggle.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// A spoiler component that shows/hides content when clicked.
class Spoiler implements CustomComponent {
  const Spoiler();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is ElementNode && node.tag == 'Spoiler') {
      final title = node.attributes['title'] ?? 'Reveal';
      final child = builder.build(node.children);

      return _SpoilerWrapper(
        title: title,
        child: child,
      );
    }
    return null;
  }

  @css
  static List<StyleRule> get styles => [
    css('.spoiler', [
      css('&').styles(
        margin: Margin.symmetric(vertical: 16.px),
        overflow: Overflow.hidden,
      ),
      css('.spoiler-title', [
        css('&').styles(
          display: Display.flex,
          border: Border.only(
            bottom: BorderSide(color: Colors.transparent, width: 1.px),
          ),
          cursor: Cursor.pointer,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          color: const Color('#0064a9'),
          fontSize: 18.px,
        ),
        css('&:hover').styles(
          border: Border.only(
            bottom: BorderSide(color: const Color('#0000001a'), width: 1.px),
          ),
        ),
      ]),
      css('.spoiler-content', [
        css('&').styles(
          display: Display.none,
        ),
        css('&[data-open="true"]').styles(
          display: Display.block,
        ),
      ]),
      css('pre').styles(
        margin: Margin.zero,
      ),
    ]),
  ];
}

/// Wrapper component that renders the spoiler structure
class _SpoilerWrapper extends StatelessComponent {
  const _SpoilerWrapper({
    required this.title,
    required this.child,
  });

  final String title;
  final Component child;

  @override
  Component build(BuildContext context) {
    return div(classes: 'spoiler', [
      SpoilerToggle(title: title),
      div(
        classes: 'spoiler-content',
        [child],
      ),
    ]);
  }
}
