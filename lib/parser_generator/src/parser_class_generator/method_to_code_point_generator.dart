part of peg.parser_generators.parser_class_generator;

class MethodToCodePointGenerator extends DeclarationGenerator {
  static const String NAME = "_toCodePoint";

  static const String _TEMPLATE = "TEMPLATE";

  static final String _template = '''
int $NAME(String string) {
  if (string == null) {
    throw new ArgumentError("string: \$string");
  }

  var length = string.length;
  if (length == 0) {
    throw new StateError("An empty string contains no elements.");
  }

  var start = string.codeUnitAt(0);
  if (length == 1) {
    return start;
  }

  if ((start & 0xFC00) == 0xD800) {
    var end = string.codeUnitAt(1);
    if ((end & 0xFC00) == 0xDC00) {
      return (0x10000 + ((start & 0x3FF) << 10) + (end & 0x3FF));
    }
  }

  return start;
}
''';

  MethodToCodePointGenerator() {
    addTemplate(_TEMPLATE, _template);
  }

  String get name => NAME;

  List<String> generate() {
    var block = getTemplateBlock(_TEMPLATE);
    return block.process();
  }
}
