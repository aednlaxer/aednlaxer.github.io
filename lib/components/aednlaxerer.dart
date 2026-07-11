import 'package:jaspr/dom.dart';
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

    final shuffled = _createShuffledName(component.value);
    setState(() => currentName = shuffled);
  }

  @override
  Component build(BuildContext context) {
    return a(
      onClick: _shuffleName,
      href: '',
      [Component.text(currentName)],
    );
  }

  String _createShuffledName(String name) {
    final letters = component.value.split('');
    final first = letters.first;
    final last = letters.last;
    final shuffled = <String>[
      // First letter is always the same
      first,

      // Middle letters are randomly shuffled
      ...letters
        ..removeAt(0)
        ..removeAt(letters.length - 1)
        ..shuffle(),

      // Last letter is always the same
      last,
    ].join();

    if (shuffled.startsWith('anal')) {
      return _createShuffledName(name);
    }

    return shuffled;
  }
}
