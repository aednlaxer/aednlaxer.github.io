import 'package:jaspr/jaspr.dart';

/// Funny component to create your own aednlaxer-like name from [value]
@client
class Aednlaxerer extends StatefulComponent {
  final String value;

  const Aednlaxerer({super.key, required this.value});

  @override
  State<StatefulComponent> createState() => AednlaxererState();
}

class AednlaxererState extends State<Aednlaxerer> {
  late String currentName;

  @override
  void initState() {
    super.initState();
    currentName = component.value;
  }

  void _shuffleName() {
    if (component.value.isEmpty || component.value.length < 2) return;

    final letters = component.value.split('');
    final shuffled = [
      // First letter is always the same
      letters.first,

      // Middle letters are randomly shuffled
      letters
        ..removeAt(0)
        ..removeAt(letters.length - 1)
        ..shuffle(),

      // Last letter is always the same
      letters.last,
    ].join();
    setState(() => currentName = shuffled);
  }

  @override
  Component build(BuildContext context) {
    return a(
      onClick: _shuffleName,
      href: '',
      [text(currentName)],
    );
  }
}
