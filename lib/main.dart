import 'package:aednlaxer_blog/components/aednlaxerer.dart';
import 'package:aednlaxer_blog/jaspr_options.dart';
import 'package:aednlaxer_blog/layouts/archive_layout.dart';
import 'package:aednlaxer_blog/layouts/page_layout.dart';
import 'package:aednlaxer_blog/layouts/post_layout.dart';
import 'package:aednlaxer_blog/secondary_output/atom_output.dart';
import 'package:aednlaxer_blog/utils/date_utils.dart';
import 'package:aednlaxer_blog/utils/constants.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/code_block.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:path/path.dart' as path;
import 'package:syntax_highlight_lite/syntax_highlight_lite.dart';

import 'layouts/home_layout.dart';
import 'styles/css.dart';

Future<void> main() async {
  Jaspr.initializeApp(options: defaultJasprOptions);
  final codeTheme = await HighlighterTheme.loadLightTheme();

  runApp(
    ContentApp.custom(
      loaders: [FilesystemLoader('content', debugPrint: false)],
      eagerlyLoadAllPages: true,
      configResolver: PageConfig.all(
        enableFrontmatter: true,
        dataLoaders: [FilesystemDataLoader('content/_data')],
        templateEngine: MustacheTemplateEngine(),
        parsers: [MarkdownParser()],
        components: [
          CodeBlock(theme: codeTheme),
          CustomComponent(
            pattern: RegExp(r'Aednlaxerer', caseSensitive: false),
            builder: (name, attr, child) {
              final nameValue = attr['name'];
              if (nameValue == null || nameValue.isEmpty) return span([]);

              // Wrap in span to avoid breaking all components after this one
              return span([
                Aednlaxerer(value: nameValue),
                ?child,
              ]);
            },
          ),
        ],
        layouts: [
          HomeLayout(),
          PostLayout(),
          SimplePageLayout(),
          ArchiveLayout(),
        ],
        secondaryOutputs: [atomOutput],
        theme: ContentTheme.none(),
      ),
    ),
  );
}

@css
List<StyleRule> get styles => GlobalStyles.styles;

AtomOutput get atomOutput => AtomOutput(
  id: Constants.siteUrl,
  author: Constants.siteAuthor,
  title: Constants.siteTitle,
  subtitle: Constants.siteDescription,
  siteUrl: Constants.siteUrl,
  filter: (page) => page.data.page['layout'] == 'post',
  itemBuilder: (page) {
    final pageData = page.data.page;
    final filename = path.basenameWithoutExtension(page.path);
    final date = parseDateFromPostUrl(filename);

    return AtomItem(
      page: page,
      id: pageUrlToPageId(page.url),
      updated: date!,
      title: pageData['title'] as String? ?? '',
      summary: pageData['description'] as String?,
      author: pageData['author'] as String?,
    );
  },
);

/// Converts a page URL to a page Id.
///
/// For compatibility with previous versions of the Atom feed, Id should look
/// like this: `http://example.com/2023/03/21/my-post`
///
/// [pageUrl] is the URL of the page to convert. Expected to be in the format:
/// `posts/2023-03-21-my-post`
String pageUrlToPageId(String pageUrl) {
  final split = pageUrl.split('/');
  final date = parseDateFromPostUrl(pageUrl);
  final pageName = split.lastOrNull?.substring(11);
  if (date == null || pageName == null) return pageUrl;

  return '${formatDateForPath(date)}/$pageName';
}
