import 'package:result/result.dart';

abstract class IListTodoUseCase {
  Future<Result> call();
}