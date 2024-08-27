// ignore_for_file: avoid_print

import 'dart:io';

void main() async {
  Directory.current = Directory(Platform.script.toFilePath()).parent.parent;
  String flutterExecutable = Platform.isWindows ? 'flutter.bat' : 'flutter';

  print("Build script for Ollama App by JHubi1");
  print("Report issues at: https://github.com/JHubi1/ollama-app/issues");

  print('----------');

  print('Extracting version from pubspec.yaml ...');
  var pubspec = File('pubspec.yaml');
  var versionLine = await pubspec
      .readAsLines()
      .then((lines) => lines.firstWhere((line) => line.contains('version')));
  var version = versionLine.split(':').last.trim().split('+').first.trim();
  var versionCode = versionLine.split(':').last.trim().split('+')[1].trim();
  print(
      "Building Ollama App v$version (build $versionCode) - this may take a while");

  print('----------');

  await execute('Android', flutterExecutable, [
    'build',
    'apk',
    '--obfuscate',
    '--split-debug-info=build\\debugAndroid'
  ]);

  // ----------

  // await execute('Windows x64', flutterExecutable, [
  //   'build',
  //   'windows',
  //   '--obfuscate',
  //   '--split-debug-info=build\\debugWindows'
  // ]);

  // await execute(
  //     'Windows x64 installer',
  //     'iscc.exe',
  //     ['windows_installer/ollama.iss', '/qp', '/dAppVersion=$version'],
  //     "  > Inno Setup is not installed. Please install it from https://www.jrsoftware.org/isdl.php#stable\n     Then add the Inno Setup directory to your PATH environment variable.");

  // ----------

  // not supported by flutter yet

  // await execute('Windows arm64', flutterExecutable, [
  //   'build',
  //   'windows',
  //   '--obfuscate',
  //   '--split-debug-info=build\\debugWindows'
  // ]);

  // await execute(
  //     'Windows arm64 installer',
  //     'iscc.exe',
  //     [
  //       'windows_installer/ollama.iss',
  //       '/qp',
  //       '/dAppVersion=$version',
  //       '/dAppArchitectures=arm64'
  //     ],
  //     "  > Inno Setup is not installed. Please install it from https://www.jrsoftware.org/isdl.php#stable\n     Then add the Inno Setup directory to your PATH environment variable.");

  print('----------');

  stdout.write('Copying build output to build\\.output ');
  try {
    var outputDir = Directory('build\\.output');
    if (await outputDir.exists()) {
      await outputDir.delete(recursive: true);
    }
    await outputDir.create();

    await copyFile('build\\app\\outputs\\flutter-apk\\app-release.apk',
        'build\\.output\\ollama-android-v$version.apk');
    await copyFile(
        'build\\windows\\x64\\runner\\ollama-windows-x64-v$version.exe',
        'build\\.output\\ollama-windows-x64-v$version.exe');
    print('- done');
  } catch (_) {
    print('- failed');
  }

  print("Output: ${Directory('build\\.output').absolute.path.toString()}");

  stdout.write('Done. Press Enter to exit. ');

  stdin.readLineSync();
}

Future<void> copyFile(String sourcePath, String destinationPath) async {
  var sourceFile = File(sourcePath);
  if (await sourceFile.exists()) {
    await sourceFile.copy(destinationPath);
  }
}

Future<void> execute(String title, String command, List<String> arguments,
    [String? errorText]) async {
  stdout.write('$title ');
  ProcessResult process;
  try {
    process = await Process.run(command, arguments);
  } catch (e) {
    print('- failed');
    print("> Errors:");
    stdout.write('\x1B[31m');
    print(e);
    stdout.write('\x1B[0m');
    if (errorText != null) {
      print(errorText);
    }
    return;
  }

  process.exitCode != 0 ? print('- failed') : print('- done');
  if (process.exitCode != 0) {
    print("> Errors:");
    stdout.write('\x1B[31m');
    process.stderr.toString().split('\n').forEach(print);
    stdout.write('\x1B[0m');
    if (errorText != null) {
      print(errorText);
    }
  }
}
