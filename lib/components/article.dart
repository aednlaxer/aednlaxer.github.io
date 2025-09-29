import 'package:aednlaxer_blog/utils/date_utils.dart';
import 'package:jaspr/jaspr.dart';

/// A component that displays a blog article.
class ArticleComponent extends StatelessComponent {
  const ArticleComponent({
    super.key,
    required this.title,
    required this.date,
    required this.child,
    required this.slug,
  });

  final String title;
  final DateTime? date;
  final Component child;
  final String? slug;

  @override
  Component build(BuildContext context) {
    return article(classes: 'post', [
      if (date != null)
        div(classes: 'post-date', [
          text(formatDate(date!)),
        ]),
      h1(classes: 'post-title', [
        if (slug != null) a(href: 'posts/$slug', [text(title)]) else text(title),
      ]),
      div(classes: 'post-content', [child]),
    ]);
  }
}
