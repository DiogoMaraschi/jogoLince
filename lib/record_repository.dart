import 'package:shared_preferences/shared_preferences.dart';

class RecordRepository {
  Future<int> buscarRecord() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('record') ?? 0;
  }

  Future<void> salvarRecord(int record) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('record', record);
  }
}
