import 'package:aednlaxer_blog/components/head.dart';
import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:aednlaxer_blog/utils/post_loader.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// A layout for the archive page that displays all posts.
class ArchiveLayout extends PageLayoutBase {
  const ArchiveLayout();

  @override
  String get name => 'archive';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield* Constants.headLinks;
  }

  @override
  Component buildBody(Page page, Component child) {
    final posts = loadPosts(currentPage: page, limit: null);

    return div(
      classes: 'container',
      [
        HeadComponent(),
        div(classes: 'posts', [
          h2([text(page.data.page['title'] as String)]),
          ul([
            for (final post in posts)
              li([
                a(
                  href: 'posts/${post.slug}',
                  [text(post.title)],
                ),
              ]),
          ]),
        ]),
      ],
    );
  }
}
