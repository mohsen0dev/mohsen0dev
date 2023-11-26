abstract class DBAdabtor {
  // create
  Future<bool> createTask({required dynamic data});

  /// read
  Future<List<dynamic>?> getAllSetData();
  Future<dynamic>? readSingleSetData({required int index});

  /// update
  Future<dynamic> updateSetData(
      {String? title, String? distance, required String currentTitle});

  /// delete
  Future<bool> deleteSetData({required int index});
}
