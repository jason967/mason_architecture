import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async {
  context.logger.progress('Genarate flutter app').complete();
  try {
    await _generateApp(context);
    context.logger.progress('flutter project create completed').complete();
  } catch (e) {
    context.logger.err('project Gen error');
  }
}

Future<ProcessResult> _generateApp(HookContext context) async {
  final progress = context.logger.progress('Running flutter project create');
  progress.complete();

  return Process.run('flutter', ['create', '{{name}}']);
}
