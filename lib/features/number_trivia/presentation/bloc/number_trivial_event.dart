part of 'number_trivial_bloc.dart';

abstract class NumberTrivialEvent extends Equatable {
  const NumberTrivialEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTrivialEvent {
  final String numberString;
  const GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTrivialEvent {
  
}
