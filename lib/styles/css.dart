import 'package:jaspr/jaspr.dart';

class _StyleConstants {
  // Font families
  static const FontFamily fontFamily = FontFamily.list([
    FontFamily('PT Serif'),
    FontFamily('Helvetica Neue'),
    FontFamily('Helvetica'),
    FontFamilies.serif,
  ]);

  static const FontFamily headingFontFamily = FontFamily.list([
    FontFamily('PT Sans'),
    FontFamily('Arial'),
    FontFamilies.sansSerif,
  ]);

  static const FontFamily codeFontFamily = FontFamily.list([
    FontFamily('Fira Code'),
    FontFamilies.monospace,
  ]);

  // Colors
  static const Color mainHeaderColor = Color('#000000');
  static const Color mainHeaderSmallColor = Color('#000000');

  static const Color postTitleColor = Color('#000000');
  static const Color postTitleUnderlineColor = Color('#0000001a');
  static const Color postDateColor = Color('#000000');

  static const Color bodyColor = Color('#000000');
  static const Color bodyColorFocused = Color('#3d3d3d');
  static const Color bodyBackgroundColor = Color('#ffffff');

  static const Color linkColor = Color('#0064a9');

  static const Color headingsColor = Color('#000000');

  static const Color strongColor = Color('#000000');

  static const Color preBackgroundColor = Color('#f9f9f9');

  static const Color blockquoteColor = Color('#000000');
  static const Color blockquoteBorderColor = Color('#e5e5e5');
}

abstract class GlobalStyles {
  static List<StyleRule> get styles => [
    css('html').styles(
      color: _StyleConstants.bodyColor,
      fontFamily: _StyleConstants.fontFamily,
      fontSize: 20.px,
      backgroundColor: Colors.white,
    ),

    // Basic typography
    css('body').styles(
      color: _StyleConstants.bodyColor,
      backgroundColor: _StyleConstants.bodyBackgroundColor,
    ),

    // Links
    css('a', [
      css('&').styles(
        border: Border.only(
          bottom: BorderSide(
            color: _StyleConstants.postTitleUnderlineColor,
            width: 1.px,
          ),
        ),
        color: _StyleConstants.linkColor,
        textDecoration: TextDecoration.none,
      ),
      css('&:hover, &:focus').styles(
        border: Border.only(
          bottom: BorderSide(
            color: _StyleConstants.linkColor,
            width: 1.px,
          ),
        ),
      ),
      css('& strong').styles(
        color: Color.inherit,
      ),
    ]),

    css('h1, h2, h3, h4, h5, h6').styles(
      margin: Spacing.only(bottom: 0.5.rem),
      color: _StyleConstants.headingsColor,
      fontFamily: _StyleConstants.headingFontFamily,
      fontWeight: FontWeight.bold,
      lineHeight: Unit.percent(125),
    ),

    css('h1').styles(
      fontSize: 1.75.rem,
    ),

    css('h2').styles(
      margin: Spacing.only(top: 1.rem),
      fontSize: 1.5.rem,
    ),

    css('h3').styles(
      margin: Spacing.only(top: 1.5.rem),
      fontSize: 1.25.rem,
    ),

    css('h4, h5, h6').styles(
      margin: Spacing.only(top: 1.rem),
      fontSize: 1.rem,
    ),

    css('p').styles(
      margin: Spacing.only(
        top: 0.px,
        bottom: 1.rem,
      ),
    ),

    css('strong').styles(
      color: _StyleConstants.strongColor,
    ),

    css('ul, ol, dl').styles(
      margin: Spacing.only(top: 0.px, bottom: 1.rem),
    ),

    css('dt').styles(
      fontWeight: FontWeight.bold,
    ),

    css('dd').styles(
      margin: Spacing.only(bottom: 0.5.rem),
    ),

    css('code, pre').styles(
      padding: Spacing.all(0.25.rem),
      overflow: Overflow.auto,
      fontFamily: _StyleConstants.codeFontFamily,
      fontSize: 0.85.em,
      backgroundColor: _StyleConstants.preBackgroundColor,
    ),

    css('pre').styles(
      padding: Spacing.all(0.5.rem),
      margin: Spacing.only(bottom: 1.rem),
      overflow: Overflow.auto,
    ),

    css('blockquote', [
      css('&').styles(
        padding: Spacing.all(0.5.rem),
        margin: Spacing.only(top: 0.8.rem, bottom: 0.8.rem),
        border: Border.only(
          left: BorderSide(
            color: _StyleConstants.blockquoteBorderColor,
            width: 0.25.rem,
          ),
        ),
        color: _StyleConstants.blockquoteColor,
      ),
      css('& p:last-child').styles(
        margin: Spacing.only(bottom: 0.px),
      ),
    ]),

    css('img').styles(
      display: Display.block,
      maxWidth: 100.percent,
      margin: Spacing.only(bottom: 1.rem),
      radius: BorderRadius.circular(5.px),
    ),

    css('.container').styles(
      minWidth: 320.px,
      maxWidth: 1024.px,
      padding: Spacing.all(1.rem),
      margin: Spacing.only(left: Unit.auto, right: Unit.auto),
    ),

    css('.main_header', [
      css('&').styles(
        padding: Spacing.only(top: 1.rem, bottom: 1.rem),
        margin: Spacing.only(bottom: 2.rem),
        fontFamily: _StyleConstants.headingFontFamily,
      ),
      css('& .main_header_title', [
        css('&').styles(
          margin: Spacing.only(top: 0.px, bottom: 0.px),
          color: _StyleConstants.mainHeaderColor,
        ),
        css('& .logo').styles(
          border: Border.none,
        ),
        css('& .logo:focus, & .logo:hover').styles(
          border: Border.none,
        ),
        css('& a').styles(
          color: _StyleConstants.mainHeaderColor,
        ),
        css('& small').styles(
          margin: Spacing.only(left: 0.5.rem),
          color: _StyleConstants.mainHeaderSmallColor,
          fontSize: 16.px,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.px,
        ),
      ]),
    ]),

    css('.posts', [
      css('&').styles(
        margin: Spacing.only(top: 0.px, bottom: 1.rem),
      ),
      css('& .post-title', [
        css('&').styles(
          margin: Spacing.only(top: 0.px),
          fontFamily: _StyleConstants.headingFontFamily,
          fontSize: 2.rem,
        ),
        css('& a', [
          css('&').styles(
            border: Border.only(
              bottom: BorderSide(
                color: _StyleConstants.postTitleUnderlineColor,
                width: 1.px,
              ),
            ),
            color: _StyleConstants.postTitleColor,
          ),
          css('&:hover, &:focus').styles(
            border: Border.only(
              bottom: BorderSide(
                color: _StyleConstants.linkColor,
                width: 1.px,
              ),
            ),
            color: _StyleConstants.bodyColorFocused,
          ),
        ]),
      ]),
      css('& .post-date').styles(
        display: Display.block,
        color: _StyleConstants.postDateColor,
        fontSize: 0.75.rem,
      ),
    ]),

    css('.code-block', [
      css('& button', [
        css('svg').styles(
          color: Colors.black,
        ),
      ]),
    ]),

    css('.footer', [
      css('&').styles(
        textAlign: TextAlign.center,
      ),
    ]),
  ];
}
