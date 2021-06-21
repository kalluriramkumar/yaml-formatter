import 'dart:io';

import 'package:args/args.dart';
import 'package:yaml_formatter/src/yaml-formatter.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addOption('path',
      abbr: 'p',
      help: 'The path of the dependencies file, which should be a yaml file');

  final results = parser.parse(arguments);
  if ((results.rest.isNotEmpty) || !results['path'].endsWith('.yaml')) {
    stderr.writeln(parser.usage);
    return;
  }
  final yamlFilePath = results['path'];
  YAMLFormatter(yamlFilePath).format();
}
