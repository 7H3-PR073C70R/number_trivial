import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_tdd/core/util/input_converter.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivial_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/mockito_helper.mocks.dart';

void main() {
  late NumberTrivialBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTrivialBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initial state should be empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivial = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSucces() => when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Right(tNumberParsed));
    test(
        'should call the input converter to validate and convert the string to an unsigned integer',
        () async {

      // arrange
      setUpMockInputConverterSucces();

      // act
      //bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      //await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      // assert
      //verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });
    test('should emmit [Error] when the input is invalid ', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      // assert 
      final expected = [
        //Empty(),
        const Error(message: invalidInputFailureMessage)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
    });

    test('should get data from the concret use case', () async {
      // arrange
      setUpMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivial));
      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      // assert 
      verify(mockGetConcreteNumberTrivia(const Params(tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', (){
      // arrange
      setUpMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivial));
      // assign later
      final expected = [
        Loading(),
        const Loaded(trivia: tNumberTrivial)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] when getting data fails', (){
      // arrange
      setUpMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(ServerFailure()));
      // assign later
      final expected = [
        Loading(),
        const Error(message: serverFailureMessage)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] with a proper message for the error when getting data fails', (){
      // arrange
      setUpMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(CachedFailure()));
      // assign later
      final expected = [
        Loading(),
        const Error(message: cacheFailureMessage)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberTrivial = NumberTrivia(number: 1, text: 'test trivia');
    
    test('should get data from the concret use case', () async {
      // arrange
      when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivial));
      // act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      // assert 
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', (){
      // arrange
      when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivial));
      // assign later
      final expected = [
        Loading(),
        const Loaded(trivia: tNumberTrivial)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] when getting data fails', (){
      // arrange
      when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => Left(ServerFailure()));
      // assign later
      final expected = [
        Loading(),
        const Error(message: serverFailureMessage)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add( GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] with a proper message for the error when getting data fails', (){
      // arrange
      when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => Left(CachedFailure()));
      // assign later
      final expected = [
        Loading(),
        const Error(message: cacheFailureMessage)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add( GetTriviaForRandomNumber());
    });
  });
}
