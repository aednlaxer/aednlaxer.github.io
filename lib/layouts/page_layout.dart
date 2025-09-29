import 'package:aednlaxer_blog/components/head.dart';
import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

class SimplePageLayout extends PageLayoutBase {
  const SimplePageLayout();

  @override
  Pattern get name => 'page';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield* Constants.headLinks;
  }

  @override
  Component buildBody(Page page, Component child) {
    return div(classes: 'container', [
      HeadComponent(),
      div(classes: 'posts', [child]),
    ]);
  }
}
