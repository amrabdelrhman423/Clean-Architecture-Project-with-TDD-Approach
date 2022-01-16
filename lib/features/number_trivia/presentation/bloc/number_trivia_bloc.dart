import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd/config/constants/errors_constants.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/core/utils/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia getTriviaRandomNumber;
  final GetConCreteNumberTrivia getTriviaConcreteNumber;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required GetConCreteNumberTrivia concrete,
      @required GetRandomNumberTrivia random,
      @required this.inputConverter})
      : assert(concrete != null),
        assert(random != null),
        getTriviaConcreteNumber = concrete,
        getTriviaRandomNumber = random, super(EmptyState());

  @override
  NumberTriviaState get initialState => EmptyState();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold((l) async* {
        yield ErrorState(
            message: ErrorMessageConst.INVALED_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield LoadingState();
        final faluierOrtrivia =
            await getTriviaConcreteNumber(Params(number: integer));
        yield* _eitherLoadedOrErrorState(faluierOrtrivia);
      });
    } else if (event is GetTriviaForRandomNumber) {
      yield LoadingState();
      final faluierOrtrivia = await getTriviaRandomNumber(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(faluierOrtrivia);
      await getTriviaRandomNumber(NoParams());
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivial> either) async* {
    yield either.fold((failure) {
      return ErrorState(message: _mapFaliureToMessage(failure));
    }, (numberTrivia) {
      return LoadedState(numberTrivial: numberTrivia);
    });
  }

  String _mapFaliureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorMessageConst.SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return ErrorMessageConst.CACHED_FAILURE_MESSAGE;
        break;
      default:
        return "Unexpected error";
    }
  }
}
