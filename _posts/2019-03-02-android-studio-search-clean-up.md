---
layout: post
title: Getting rid of generated files in search dialog in Android Studio
---

> This is an old post. It was originally posted on [Medium](https://medium.com/@aednlaxer/getting-rid-of-generated-files-in-search-dialog-in-android-studio-ae466a1261a4)

Have you ever seen a picture like this when looking for a file or a class in Android Studio?

{{ /assets/search-fixes/search-dialog-before.png:img?width=250 alt='steam-fish-1' }}
![](/assets/search-fixes/search-dialog-before.png)

It's populated mostly by unrelated generated files. They're always blocking you from finding the right one. Luckily, there's a way to tell Android Studio (or any flavor of IntelliJ IDEA) to ignore these files.

My first idea was to make Android Studio ignore the build folder but it didn't work properly when you needed to reference `BuildConfig` or any other generated class.

Another way of fixing the issue would be getting generated file names, creating name masks and ignoring them. This is what I found for our project.

Realm:
```
*RealmProxy.java
*RealmProxyInterface.class
*RealmProxyInterface.java
```

Dagger:
```
*_MembersInjector.java
*_Factory.java
_Provide*Factory.java
*Module_*.java
```

Be careful with the last one. Our Dagger modules are called like `CommonToolsModule.java` so we can easily ignore all the module-related generated files using that mask.

ButterKnife:
```
_ViewBinding.java
```

Parceler:
```
*$$Parcelable.java
```

Add these masks to `Preferences` → `Editor` → `File Types` → `Ignore files and folders` field as semicolon-separated values. Applying these changes will affect `File…` and `Class…` dialogs, search dialog and usage search.

There's one more little guy that annoys me every time I'm looking for a string in a project using `Find in path` or `Replace in path` dialogs. Its name is lint report. Let's add `lint-report.html` to the list of ignored files too.

The final configuration looks like this:

```
*RealmProxy.java;*RealmProxyInterface.class;*RealmProxyInterface.java;*_MembersInjector.java*_Factory.java;_Provide*Factory.java;*Module_*.java;*_ViewBinding.java;*$$Parcelable.java
```

And the result is:

![](/assets/search-fixes/search-dialog-after.png)
