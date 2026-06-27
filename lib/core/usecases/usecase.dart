import 'package:kms/core/errors/failures.dart';
import 'package:kms/core/utils/result.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

class NoParams {}
