import 'package:dartz/dartz.dart';

import '/index.dart';
 

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;