import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

class AtomItem {
  const AtomItem({
    required this.page,
    required this.title,
    required this.id,
    required this.updated,
    this.summary,
    this.content,
    this.author,
  });

  final Page page;
  final String title;
  final String id;
  final DateTime updated;

  final String? summary;
  final String? content;
  final String? author;
}

/// A [SecondaryOutput] that outputs an Atom feed for blog pages
class AtomOutput extends SecondaryOutput {
  AtomOutput({
    required this.filter,
    required this.itemBuilder,
    required this.title,
    required this.subtitle,
    required this.siteUrl,
    required this.id,
    required this.author,
  });

  final String title;
  final String subtitle;
  final String siteUrl;
  final String id;
  final String author;

  final bool Function(Page page) filter;
  final AtomItem Function(Page page) itemBuilder;

  @override
  final Pattern pattern = RegExp(r'/?index\..*');

  @override
  String createRoute(String route) => '/atom.xml';

  @override
  Component build(Page page) {
    return Builder(
      builder: (context) {
        context.setHeader('Content-Type', 'application/atom+xml');
        context.setStatusCode(200, responseBody: _renderAtomFeed(context.pages));
        return text('');
      },
    );
  }

  String _renderAtomFeed(List<Page> pages) {
    final HtmlEscape htmlEscape = HtmlEscape();
    final escapeXml = htmlEscape.convert;

    final atomItems = pages
        .where((page) => filter(page))
        .map((page) => itemBuilder(page))
        .sortedBy(((item) => -item.updated.millisecondsSinceEpoch))
        .toList();

    final lastUpdated = atomItems.lastOrNull?.updated.toIso8601String();
    final entries = <String>[];

    for (final item in atomItems) {
      final entryId = '$siteUrl/${item.id}';
      final entryUrl = '$siteUrl${item.page.url}';
      final updated = item.updated.toIso8601String();

      final entry = _buildEntry(
        escapeXml: escapeXml,
        title: item.title,
        id: entryId,
        url: entryUrl,
        updated: updated,
        author: author,
        summary: item.summary,
        content: item.content,
      );
      entries.add(entry);
    }

    return _buildFeed(
      escapeXml: escapeXml,
      title: title,
      subtitle: subtitle,
      siteUrl: siteUrl,
      id: id,
      lastUpdated: lastUpdated,
      author: author,
      entries: entries,
    );
  }

  String _buildEntry({
    required String Function(String) escapeXml,
    required String title,
    required String id,
    required String url,
    required String updated,
    required String? author,
    required String? summary,
    required String? content,
  }) {
    var entrySource =
        '''
<entry>
      <title>${escapeXml(title)}</title>
      <id>$id</id>
      <link href="$url"/>''';

    if (summary != null) {
      entrySource += '<summary>${escapeXml(summary)}</summary>';
    }

    if (content != null) {
      entrySource += '<content type="html">${escapeXml(content)}</content>';
    }

    entrySource += '<updated>$updated</updated>';

    if (author != null) {
      entrySource +=
          '''
      <author>
        <name>${escapeXml(author)}</name>
      </author>''';
    }

    entrySource += '''
    </entry>''';

    return entrySource;
  }

  String _buildFeed({
    required String Function(String) escapeXml,
    required String title,
    required String subtitle,
    required String siteUrl,
    required String id,
    required String author,
    required List<String> entries,
    required String? lastUpdated,
  }) {
    var feed =
        '''<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title>${escapeXml(title)}</title>
  <subtitle>${escapeXml(subtitle)}</subtitle>
  <link href="$siteUrl"/>
  <link rel="self" href="$siteUrl/atom.xml"/>
  <id>$id</id>
  <updated>$lastUpdated</updated>''';

    feed = author.isNotEmpty
        ? '''$feed
  <author>
    <name>${escapeXml(author)}</name>
  </author>'''
        : feed;

    feed =
        '''$feed
${entries.join('\n')}
</feed>''';

    return feed;
  }
}
