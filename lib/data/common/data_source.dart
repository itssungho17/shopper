abstract class DataSource<T> {
  Future<T> addOne(T item);
  Future<T> deleteOne(T item);
  Future<List<T>> getAll();
  Future<T> getOne(String key);
  Future<T> updateOne(T item);
}
