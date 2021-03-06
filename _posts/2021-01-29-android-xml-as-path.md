---
layout: post
title: Getting Android vector drawable as Path
---

You ever wondered how to get a `Path` from Android's vector XML drawable to draw it on canvas? Here are some options.

<hr/>

Getting a vector drawable and drawing it on a `canvas` with any size is easy:

{% highlight kotlin %}
val vectorDrawable = ResourcesCompat.getDrawable(resources, R.drawable.icon, null)

vectorDrawable?.setBounds(0, 0, 800, 800)
vectorDrawable?.draw(canvas)
{% endhighlight %}

This produces a vector drawable which is properly scaled and looks sharp in most cases. Although if you scale this image too much some artifacts may appear, scaled icon may become blurry. Look how sharp the text is and how pixelated the scaled shape is:

![](/assets/android-xml-as-path/sharp-not-really.png)

In case you want to have better scaling and implement advanced features with paint, gradients and shaders you might need to get a vector drawable as instance of `Path`.

## Understanding XML path data

Each vector XML file contains instructions how to draw it. Compare parts of XML and Kotlin representation of the same icon:

{% highlight xml %}
<path
    android:fillColor="#FF000000"
    android:pathData="M17.6,9.48l1.84,-3.18c0.16,-0.31 0.04,-0.69 -0.26,..."/>
{% endhighlight %}

{% highlight kotlin %}
path.moveTo(17.6f, 9.48f)
path.lineTo(19.44f, 6.3f)
path.cubicTo(19.6f, 5.99f, 19.48f, 5.61f, 19.18f, 5.45f)
{% endhighlight %}

This XML drawable contains path instructions which can be mapped into a set of `Path` calls:

- `M` is translated to `moveTo`
- `l` is translated to `lineTo`
- `c` is translated to `cubicTo`

Uppercase is for absolute coordinates, lowercase is for coordinates relative to previous instruction. Thus, `l1.84,-3.18` following `M17.6,9.48` becomes `lineTo(19.44f, 6.3f)`. Quick maths:

- First argument: 17.6 + 1.84 = 19.44
- Second argument 9.48 - 3.18 = 6.3

It's possible to manually build a `Path` object that matches instructions of an XML drawable. Although it'll probably take a lot of your time. It's also easy to make a typo.

Read more about XML path data in [this awesome article.](https://medium.com/@ali.muzaffar/understanding-vectordrawable-pathdata-commands-in-android-d56a6054610e)

## Generating Path code from vector image using an online generator

[codecrafted.net/svgtoandroid](https://codecrafted.net/svgtoandroid) is online generator that converts an SVG file into Java code, similar to what was demonstrated in the previous section. Resulting code can be optimized and improved by converting it to Kotlin and checking that all variables have meaningful names. Always think twice before uploading any of your app code including SVG icons into 3rd party services.

## Converting vector XML into Path programmatically

A `Path` can be created from a `String` containing path instructions. There are two main steps to convert a vector drawable into `Path`:

1. Parse content of a vector XML drawable and extract `pathData` attribute from it
2. Create new `Path` object from path data

[This gist](https://gist.github.com/aednlaxer/9e3ccc56bb72253966b2e298e2700751) shows how you can implement a parser for a simple XML with one `path` node. Getting a `Path` from path data string is trivial:

{% highlight kotlin %}
import androidx.core.graphics.PathParser

PathParser.createPathFromPathData(pathData)
{% endhighlight %}

Look how sharp this shape is after scaling a `Path` using `Matrix`:

![](/assets/android-xml-as-path/sharp-yes.png)

A complete example will be provided later as a part of a bigger project.
