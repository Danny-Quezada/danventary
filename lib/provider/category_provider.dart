import 'package:flutter/foundation.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';

class CategoryProvider extends ChangeNotifier with MessageNotifierMixin{
  ICategoryModel iCategoryModel;

  CategoryProvider({required this.iCategoryModel});
}