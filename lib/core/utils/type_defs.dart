import 'package:dartz/dartz.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

// to create one short generic name for a type
typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, Object?>;
