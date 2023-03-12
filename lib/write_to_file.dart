import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

void writeToFile(int xp) async {
  List<Result> times = await writeStatsToCSV(xp);
  writeHTML(times);
}

class Result {
  const Result(this.xp, this.time);

  final int xp;
  final DateTime time;

  String toCSVString() {
    String timeAsString = time.toIso8601String();
    return '$xp,$timeAsString';
  }
}

Future<List<Result>> writeStatsToCSV(int xp) async {
  String saveDirectory = await _saveDirectory;
  File file = File('$saveDirectory/stats.csv');
  List<String> asLines = await readLines(file);
  List<Result> asTimes = asLines.map(toResult).toList();
  asTimes.add(Result(xp, DateTime.now()));
  List<Result> sortedTimes = insertionSort(asTimes);
  writeXP(sortedTimes, file);
  return sortedTimes;
}

Future<List<String>> readLines(File file) async {
  if (file.existsSync()) {
    return await file.readAsLines();
  } else {
    return [];
  }
}

Result toResult(String csv) {
  List<String> splitIntoList = csv.split(',');
  int xp = int.parse(splitIntoList[0]);
  DateTime time = DateTime.parse(splitIntoList[1]);
  return Result(xp, time);
}

List<Result> insertionSort(List<Result> stats) {
  for (int i = 0; i < stats.length; i++) {
    Result value = stats[i];
    int index = i;
    while (index > 0 && value.xp > stats[index - 1].xp) {
      stats[index] = stats[index - 1];
      index--;
    }
    stats[index] = value;
  }
  return stats;
}

void writeXP(List<Result> sortedTimes, File file) {
  Iterable<String> lines = sortedTimes.map((e) => e.toCSVString());
  String stringToWrite = lines.reduce((collected, line) => '$collected\n$line');
  file.writeAsString(stringToWrite);
}

void writeHTML(List<Result> sortedTimes) async {
  String saveDirectory = await _saveDirectory;
  String path = '$saveDirectory/stats.html';
  File file = File(path);
  file.writeAsStringSync('''<!DOCTYPE html>
<html lang="en">

<head>
	<title>Polibility statistics</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body><table>
	<thead><tr>
		<th>XP</th>
		<th>Date</th>
	</tr></thead>
	<tbody>
''');
  for (int i = 0; i < sortedTimes.length; i++) {
    int xp = sortedTimes[i].xp;
    String time = sortedTimes[i].time.toIso8601String();
    file.writeAsStringSync(
      '		<tr><td>$xp</td><td>$time</td></tr>\n',
      mode: FileMode.append,
    );
  }
  file.writeAsStringSync(
    '</tbody></table></body></html>',
    mode: FileMode.append,
  );
  launchUrlString('file:$path');
}

Future<String> get _saveDirectory async {
  final rootDirectory = await _rootDirectory;
  final rootDirectoryPath = rootDirectory.path;
  final saveDirectoryPath = '$rootDirectoryPath/polybility';
  Directory(saveDirectoryPath).createSync();
  return saveDirectoryPath;
}

Future<Directory> get _rootDirectory async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    final directory = await getExternalStorageDirectory();
    if (directory != null) {
      return directory;
    }
  }

  return getApplicationDocumentsDirectory();
}
