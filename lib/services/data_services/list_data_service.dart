abstract class ListDataService<T> {
  Future<void> updateRemoteAll();
  Future<void> updateRemoteOne(String id);
  int getIndex(String id);
  List<T> getAll();
  T? getOne(String id);
}
