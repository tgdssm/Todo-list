import 'package:result/result.dart';

abstract class IDeleteTodoUseCase {
  Future<Result> call(String todoID);
}