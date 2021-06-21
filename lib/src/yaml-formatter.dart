import 'package:yaml/yaml.dart';
import 'dart:io';

class YAMLFormatter {
  /// Counter variable sets the indentations
  // Setting initially to -1
  int counter = -1;

  var file;

  YAMLFormatter(String path) {
    file = File(path);
  }

  void format() {
    var _yamlMap = YamlMap();
    if (file.existsSync()) {
      _yamlMap = loadYaml(file.readAsStringSync());
    }
    // Clears the file content.
    file.writeAsStringSync('');
    _formatter(_yamlMap);
  }

  /// Formats the YAML file.
  void _formatter(Map map) {
    // Increments the counter variable.
    counter++;
    var itr = map.keys.iterator;
    while (itr.moveNext()) {
      var element = itr.current;
      var value = map[element];
      if (value is Map) {
        file.writeAsStringSync('${' ' * (counter * 2)}$element:\n',
            mode: FileMode.append);
        _formatter(value);
        continue;
      }
      if (element is String) {
        if (element == 'sdk') {
          value = '\'$value\'';
        }
        file.writeAsStringSync('${' ' * (counter * 2)}$element: $value\n',
            mode: FileMode.append);
      }
    }
    counter = 0;
    file.writeAsStringSync('\n', mode: FileMode.append);
  }
}
