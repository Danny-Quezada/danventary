import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/models/category.dart';

class CategoryRepository implements ICategoryModel{
  @override
  Future<int> create(Category t) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<String> delete(Category t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<String> update(Category t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}