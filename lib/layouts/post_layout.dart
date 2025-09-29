import 'package:aednlaxer_blog/components/article.dart';
import 'package:aednlaxer_blog/components/head.dart';
import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:aednlaxer_blog/utils/date_utils.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

class PostLayout extends PageLayoutBase {
  const PostLayout();

  @override
  String get name => 'post';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield Constants.fontsHeadLink;
    yield Constants.faviconHeadLink;
  }

  @override
  Component buildBody(Page page, Component child) {
    final title = page.data.page['title'] as String;
    final slug = page.data.page['slug'] as String?;
    final postUrl = page.data.page['url'] as String?;
    final dateTime = parseDateFromPostUrl(postUrl);

    return div(classes: 'container', [
      HeadComponent(),
      div(classes: 'posts', [
        ArticleComponent(
          title: title,
          date: dateTime,
          slug: slug,
          child: child,
        ),
      ]),
    ]);
  }
}
