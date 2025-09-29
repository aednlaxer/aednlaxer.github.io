import 'dart:io';

import 'package:aednlaxer_blog/utils/date_utils.dart';
import 'package:collection/collection.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as path;

List<BlogPost> loadPosts({required Page currentPage, required int? limit}) {
  final postsDir = Directory('content/posts');
  if (!postsDir.existsSync()) return const [];

  var posts = <BlogPost>[];

  for (final file in postsDir.listSync().whereType<File>()) {
    if (path.extension(file.path) == '.md') {
      try {
        final content = file.readAsStringSync();
        final post = _parsePost(file.path, content, currentPage);
        if (post != null) posts.add(post);
      } catch (e) {
        // Skip files that can't be read
        print('Error parsing post: $e');
        continue;
      }
    }
  }

  // Sort by date (newest first) and limit the number of returned posts
  posts = posts.sorted((a, b) => b.date.compareTo(a.date));

  if (limit != null) posts = posts.take(limit).toList();

  return posts;
}

BlogPost? _parsePost(String filePath, String content, Page currentPage) {
  final lines = content.split('\n');
  if (lines.isEmpty || lines[0] != '---') return null;

  final frontMatterEnd = lines.indexOf('---', 1);
  if (frontMatterEnd == -1) return null;

  String? title;
  String? layout;

  // Parse front matter
  for (int i = 1; i < frontMatterEnd; i++) {
    final line = lines[i].trim();
    if (line.startsWith('title:')) {
      title = line.substring(6).trim();
      // Remove quotes if present
      if (title.startsWith('"') && title.endsWith('"')) {
        title = title.substring(1, title.length - 1);
      }
    } else if (line.startsWith('layout:')) {
      layout = line.substring(7).trim();
    }
  }

  if (title == null || layout != 'post') return null;

  // Extract filename and date
  final filename = path.basenameWithoutExtension(filePath);
  final date = parseDateFromPostUrl(filename);
  if (date == null) return null;

  // Get the full markdown content after front matter
  final markdownContent = lines.sublist(frontMatterEnd + 1).join('\n');

  // Create a temporary page to use jaspr's markdown parser
  final postPath = 'posts/$filename.md';
  final postPage = Page(
    path: postPath,
    url: '/posts/$filename',
    content: markdownContent,
    config: currentPage.config,
    loader: currentPage.loader,
  );

  final slug = filename;

  return BlogPost(
    title: title,
    date: date,
    slug: slug,
    page: postPage,
  );
}

class BlogPost {
  final String title;
  final DateTime date;
  final String slug;
  final Page page;

  const BlogPost({
    required this.title,
    required this.date,
    required this.slug,
    required this.page,
  });
}
