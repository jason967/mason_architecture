import 'package:mason/mason.dart';
import 'dart:io';

Future<void> run(HookContext context) async {
  final logger = context.logger.progress('Genarate flutter app');

  try {
    final end = context.logger.progress('flutter project create completed');
    await _generateApp(context);
    end.complete();
  } catch (e) {
    context.logger.err('project Gen error');
  }
  logger.complete();
}

Future<void> _generateApp(HookContext context) async {
  final String name = context.vars['name'];

  final progress =
      context.logger.progress('Running flutter project create ${name}');
  await Process.run('flutter', ['create', '--platforms=ios,android', '$name']);
  progress.complete();
}
