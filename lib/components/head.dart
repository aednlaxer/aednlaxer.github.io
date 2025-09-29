import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:jaspr/jaspr.dart';

/// A component that displays the main header of the blog with site menu.
class HeadComponent extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(classes: 'main_header', [
      header(classes: 'main_header_title', [
        a(
          classes: 'logo',
          href: '/',
          [
            strong([text(Constants.siteTitle)]),
          ],
        ),
        small([
          a(href: 'atom.xml', [text('RSS')]),
        ]),
        small([
          a(href: 'archive', [text('Archive')]),
        ]),
        small([
          a(href: 'about', [text('About')]),
        ]),
      ]),
    ]);
  }
}
