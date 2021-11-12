import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_tdd/core/util/input_converter.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivial_event.dart';
part 'number_trivial_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cahce Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTrivialBloc extends Bloc<NumberTrivialEvent, NumberTrivialState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTrivialBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<NumberTrivialEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);
        inputEither.fold((failure) {
          emit(const Error(message: invalidInputFailureMessage));
        }, (integer) async {
          emit(Loading());
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(integer));
          _eitherLoadedOrErrorState(emit, failureOrTrivia);
        });
      } else if (event is GetTriviaForRandomNumber){
        emit(Loading());
          final failureOrTrivia =
              await getRandomNumberTrivia(NoParams());
          _eitherLoadedOrErrorState(emit, failureOrTrivia);
      }
    });
  }

  void _eitherLoadedOrErrorState(Emitter<NumberTrivialState> emit, Either<Failure, NumberTrivia> failureOrTrivia) {
    emit(failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivial) => Loaded(trivia: trivial)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CachedFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
