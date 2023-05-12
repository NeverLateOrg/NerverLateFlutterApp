abstract class ListDataService<T> {
  Future<void> syncRemoteAll();
  Future<void> syncRemoteOne(String id);
  int getIndex(String id);
  List<T> getAll();
  T? getOne(String id);
  // clear locally (for example when logout)
  void reset();
}
