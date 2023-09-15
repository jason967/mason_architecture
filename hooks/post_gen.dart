import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _moveFile(context);
  await _removeFiles(context, '.gitkeep');
}

Future<void> _removeFiles(HookContext context, String name) async {
  final logger = context.logger.progress('removing $name files ...');
  logger.complete();
  var dir = Directory('.');

  await dir
      .list(recursive: true)
      .where((element) => element.toString().contains(name))
      .listen(
    (element) {
      element.delete();
    },
    onDone: () {
      final kkk = context.logger.progress('$name files removed');
      kkk.complete();
    },
  );
}

Future<void> _AddPackages(HookContext context, String name) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'add', name]);
  await Process.run('flutter', ['pub', 'get']);

  progress.complete();
}

Future<void> _moveFile(HookContext context) async {
  final moves = context.logger.progress('move files ...');
  moves.complete();
  final String name = context.vars['name'];

  await Process.run('rm', ['./$name/lib']);

  var result = await Process.run('mv', [
    'lib',
    './$name/',
  ]);
  if (result.exitCode == 0) {
    final done = context.logger.progress('move files done');
    done.complete();
  } else {
    context.logger.err(result.stderr);
  }
}
