---
layout: post
title: Time Flies with Riverpod
---

Have you ever had that list item that shows relative time to the current moment, something like “5 minutes ago” or “two days ago”?

![A relative timestamp showing "Sent 5 minutes ago"](/assets/time-flies-with-riverpod/relative-timestamp.png)

It’s usually easy to implement: simply use an existing package like [`timeago`](https://pub.dev/packages/timeago) that takes an event’s `DateTime` and current `DateTime` and returns a relative timestamp.

However, it’s also easy to make these relative timestamps outdated. Using `DateTime.now()` to get the current time is fine at the moment when `DateTime.now()` is called but it's not fine when `DateTime.now()` was last called 10 minutes ago and the timestamp still shows “just now”.

# The provider

A colleague of mine introduced this small Riverpod provider to one of the projects years ago and I've been using it ever since:

```dart
/// Returns current time and updates it every minute.
final nowProvider = StateProvider<DateTime>((ref) {
  final timer = Timer.periodic(const Duration(seconds: 1), (_) {
    final now = DateTime.now();
    if (ref.controller.state.minute != now.minute) {
      ref.controller.state = now;
    }
  });

  ref.onDispose(timer.cancel);

  return DateTime.now();
});
```

<Spoiler title="Riverpod 3 code snippet">

```dart
final nowProvider = NotifierProvider<NowNotifier, DateTime>(NowNotifier.new);

class NowNotifier extends Notifier<DateTime> {
  Timer? timer;

  @override
  DateTime build() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (state.minute != now.minute) {
        state = now;
      }
    });

    ref.onDispose(() => timer?.cancel());

    return DateTime.now();
  }
}
```

</Spoiler>

Watch provider using simple `ref.watch`:

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // This is current time, updated automatically
  final now = ref.watch(nowProvider);
```

`nowProvider` immediately returns a value upon subscription and starts a timer that runs a `DateTime` check every second.

Every time it runs, it checks if the minute value has changed from the last emitted value. It’s too much to update the UI every second, and this provider avoids that. Instead, it only emits a new value if a minute value changes (e.g. 16:05 changes to 16:06). It delivers an up-to-date timestamp every minute with a maximum delay of 1 second.

# Tests

This provider can be overridden in widget tests allowing the time to be fixed and eliminating problems with timer disposal:

```dart
await tester.pumpWidget(
  UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [
        // Your other provider overrides here
        nowProvider.overrideWith((ref) => DateTime(2025, 10, 13)),
      ],
    ),
    child: const MyFancyWidget(),
  ),
);
```

<Spoiler title="Riverpod 3 code snippet">

```dart

...
nowProvider.overrideWith(() => FakeNowNotifier(DateTime(2025, 10, 13))),
...

// Slightly more code for Riverpod 3 to create a FakeNowNotifier
class FakeNowNotifier extends NowNotifier {
  final DateTime dateTime;

  FakeNowNotifier(this.dateTime);

  @override
  DateTime build() => dateTime;
}

```

</Spoiler>

# Not just relative timestamps

You can use this provider everywhere for centralized time access and get precise time control in widget tests for free.

Like any other provider, watching this provider makes UI reactive. If, for example, your app shows that a restaurant is open at the moment by comparing current time to restaurant's working hours, this provider will trigger a UI update for current status text and color:

```dart
final now = ref.watch(nowProvider);
final isRestaurantOpen = myRestaurant.isOpen(now);
final highlightColor = isRestaurantOpen ? Colors.green : Colors.red;
final statusText = isRestaurantOpen ? 'Open' : 'Closed';
```

![List tile showing that restaurant is open for 45 more minutes](/assets/time-flies-with-riverpod/usage-example.png)