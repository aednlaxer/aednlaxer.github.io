import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

/// Client-side stateful component that handles the spoiler toggle button
@client
class SpoilerToggle extends StatefulComponent {
  const SpoilerToggle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<StatefulComponent> createState() => _SpoilerToggleState();
}

class _SpoilerToggleState extends State<SpoilerToggle> {
  bool isOpen = false;

  void _toggle(web.Event e) {
    setState(() => isOpen = !isOpen);

    // Toggle the visibility of the next sibling (spoiler content)
    final titleElement = e.currentTarget as web.Element;
    final contentElement = titleElement.nextElementSibling;

    if (contentElement != null) {
      if (isOpen) {
        contentElement.setAttribute('data-open', 'true');
      } else {
        contentElement.removeAttribute('data-open');
      }
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'spoiler-title',
      events: {'click': _toggle},
      [text(component.title)],
    );
  }
}
