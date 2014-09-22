part of peg.parser_generators.parser_generator;

class ParserGenerator extends TemplateGenerator {
  static const String _TEMPLATE = 'TEMPLATE';

  static final String _template = '''
// This code was generated by a tool.
// Processing tool available at https://github.com/mezoni/peg

{{#GLOBALS}}
{{#CLASSES}}
''';

  final Grammar grammar;

  final String name;

  final ParserGeneratorOptions options;

  Map<String, List<String>> _classes;

  ParserGenerator(this.name, this.grammar, this.options) {
    if (name == null) {
      throw new ArgumentError("name: $name");
    }

    if (grammar == null) {
      throw new ArgumentError("grammar: $grammar");
    }

    if (options == null) {
      throw new ArgumentError("options: $options");
    }

    addTemplate(_TEMPLATE, _template);
    _classes = <String, List<String>>{};
  }

  void addClass(DeclarationGenerator declaration) {
    if (declaration == null) {
      throw new ArgumentError("declaration: $declaration");
    }

    _addDeclaration(declaration, _classes);
  }

  List<String> generate() {
    var block = getTemplateBlock(_TEMPLATE);
    if (grammar.globals != null) {
      block.assign("#GLOBALS", Utils.codeToStrings(grammar.globals));
    }

    addClass(new ParserErrorClassGenerator(ParserErrorClassGenerator.getName(name)));
    _generateDeclarations(block, "#CLASSES", _classes);
    return block.process();
  }

  void _addDeclaration(DeclarationGenerator generator, Map<String, List<String>> members) {
    var name = generator.name;
    if (members.containsKey(name)) {
      throw new StateError("Declaration generator with name '$name' already exists.");
    }

    members[name] = generator.generate();
  }

  void _generateDeclarations(TemplateBlock block, String key, Map<String, List<String>> members) {
    var names = members.keys.toList();
    names.sort((a, b) => a.compareTo(b));
    for (var name in names) {
      block.assign(key, members[name]);
    }
  }
}