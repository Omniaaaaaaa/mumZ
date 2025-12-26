import 'package:shared_preferences/shared_preferences.dart';


class SpeakerLocalStorage {
  final SharedPreferences prefs;

  SpeakerLocalStorage(this.prefs);

  Future<void> saveSpeakerPaths(List<String> paths) async {
    await prefs.setStringList('speaker_paths', paths);
  }

  List<String>? getSpeakerPaths() => prefs.getStringList('speaker_paths');
}
