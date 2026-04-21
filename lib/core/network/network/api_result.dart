abstract class ApiResult<T> {
  const ApiResult();
  factory ApiResult.success(T data) => Success(data);
  factory ApiResult.failure(String error) => Failure(error);
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return failure((this as Failure<T>).error);
    }
    throw Exception('Unknown ApiResult type');
  }

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String error)? failure,
  }) {
    if (this is Success<T>) {
      return success?.call((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return failure?.call((this as Failure<T>).error);
    }
    return null;
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);

  @override
  String toString() => 'Success(data: $data)';
}

class Failure<T> extends ApiResult<T> {
  final String error;

  const Failure(this.error);

  @override
  String toString() => 'Failure(error: $error)';
}
