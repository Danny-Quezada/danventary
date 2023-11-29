abstract class IModel<T> {
  Future<int> create(T t);
  Future<String> update(T t);
  Future<List<T>> read();
  Future<String> delete(T t);
}
