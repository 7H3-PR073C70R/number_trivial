import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      return integer < 0 ? Left(InvalidInputFailure()) : Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
