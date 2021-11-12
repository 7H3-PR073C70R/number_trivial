import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('String to unsigned in', () {
    test('Should return an integer when the string represents an unsigned integer', (){
      // arrange
      const str = '123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, const Right(123));
    });

    test('Should return a failure when the string is not an integer', (){
      // arrange
      const str = '1.0';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result,  Left(InvalidInputFailure()));
    });

    test('Should return a failure when the string is a negative integer', (){
      // arrange
      const str = '-123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result,  Left(InvalidInputFailure()));
    });
   });
}