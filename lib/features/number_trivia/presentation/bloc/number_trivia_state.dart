part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super([props]);
}

class EmptyState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivial numberTrivial;
  LoadedState({@required this.numberTrivial}) : super([numberTrivial]);
}

class ErrorState extends NumberTriviaState {
  final String message;
  ErrorState({@required this.message}) : super([message]);
}
