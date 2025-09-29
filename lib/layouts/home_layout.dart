import 'package:aednlaxer_blog/components/article.dart';
import 'package:aednlaxer_blog/components/head.dart';
import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:aednlaxer_blog/utils/post_loader.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// A layout for the home page that automatically lists all recent posts.
class HomeLayout extends PageLayoutBase {
  const HomeLayout();

  @override
  String get name => 'home';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield Constants.fontsHeadLink;
    yield Constants.faviconHeadLink;
  }

  @override
  Component buildBody(Page page, Component child) {
    final posts = loadPosts(
      currentPage: page,
      limit: Constants.homePagePostsLimit,
    );

    return div(classes: 'container', [
      HeadComponent(),
      div(classes: 'posts', [
        for (final post in posts) _buildFullPost(post),
      ]),
      div(classes: 'footer', [
        text('Older articles available in '),
        a(href: '/archive', [text('the archive')]),
      ]),
    ]);
  }

  Component _buildFullPost(BlogPost post) {
    final contentComponents = _renderPostContent(post);
    if (contentComponents == null) return div([]);

    return ArticleComponent(
      title: post.title,
      date: post.date,
      slug: post.slug,
      child: contentComponents,
    );
  }

  Component? _renderPostContent(BlogPost post) {
    try {
      // Use jaspr_content's official NodesBuilder to convert nodes to components
      final nodes = post.page.parseNodes();
      final builder = NodesBuilder(post.page.config.components);
      final component = builder.build(nodes);
      return component;
    } catch (e) {
      return null;
    }
  }
}
