import 'package:jaspr/jaspr.dart';

abstract class Constants {
  static const String siteTitle = 'aednlaxer';
  static const String siteAuthor = 'aednlaxer';
  static const String siteDescription = 'Alexander Troshkov\'s blog';
  static const String siteUrl = 'https://aednlaxer.github.io';

  static const int homePagePostsLimit = 3;

  static Component get fontsHeadLink {
    return link(
      href:
          'https://fonts.googleapis.com/css2?family=Fira+Code&family=PT+Sans:wght@400;700&family=PT+Serif:wght@400;700&display=swap',
      rel: 'stylesheet',
    );
  }

  static Component get faviconHeadLink {
    return link(
      href: 'favicon.ico',
      rel: 'icon',
      type: 'image/x-icon',
    );
  }
}
