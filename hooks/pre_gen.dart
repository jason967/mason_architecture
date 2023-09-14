import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async {
  final appGen = context.logger;

  appGen.progress('Genarate flutter app');
  try {
    await _generateApp(context);
    appGen.progress('flutter project create completed').complete();
  } catch (e) {
    context.logger.err('project Gen error');
  }
}

Future<ProcessResult> _generateApp(HookContext context) async {
  final progress = context.logger.progress('Running flutter project create');
  progress.complete();

  return Process.run('flutter', ['create', '{{name}}']);
}
