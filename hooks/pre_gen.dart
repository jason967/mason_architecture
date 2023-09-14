import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async {
  final logger = context.logger.progress('Genarate flutter app');

  try {
    await _generateApp(context);
    final end = context.logger.progress('flutter project create completed');
    end.complete();
  } catch (e) {
    context.logger.err('project Gen error');
  }
  logger.complete();
}

Future<void> _generateApp(HookContext context) async {
  final progress = context.logger.progress('Running flutter project create');

  await Process.run('flutter', ['create', '{{name}}']);

  progress.complete();
}
