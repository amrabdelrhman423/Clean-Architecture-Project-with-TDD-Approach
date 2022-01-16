import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/src/config/constants/errors_constants.dart';
import 'package:tdd/src/core/error/failures.dart';
import 'package:tdd/src/core/usecases/usecase.dart';
import 'package:tdd/src/core/utils/input_converter.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_concrete_number.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConCreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test("initialState Should be Empty State", () async {
    //assert
    expect(bloc.initialState, equals(EmptyState()));
  });

  testGetNumberTriviaForConcreteNumber() {
    final tNumberString = "5";
    final tNumberParse = 5;
    final tNumberTRivia = NumberTrivial(text: "test Number Trivia", number: 5);
    setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParse));
    test(
        "should called inputConvert to validate and convert the String to unSigned integer",
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });
    test("should emit [Error] when the input is invalid", () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      //assert later
      final expected = [
        EmptyState(),
        ErrorState(message: ErrorMessageConst.INVALED_INPUT_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
    test("should get data from cocrete Use Case", () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTRivia));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParse)));
    });
    test(
        "should emit [loading state , loaded state] when data is getting successfully",
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTRivia));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        LoadedState(numberTrivial: tNumberTRivia)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        "should emit [loading state , Error state] when data is getting Unsuccessfully With Server ",
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: ErrorMessageConst.SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
    test(
        "should emit [loading state , Error state] when data is getting Unsuccessfully With Cache ",
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: ErrorMessageConst.CACHED_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
  }

  group("getTriviaForConcreteNumber", () {
    testGetNumberTriviaForConcreteNumber();
  });

  testGetNumberTriviaForRandomNumber() {
    final tNumberTRivia = NumberTrivial(text: "test Number Trivia", number: 5);

    test("should get data from random Use Case", () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTRivia));
      // act
      bloc.dispatch(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      // assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });
    test(
        "should emit [loading state , loaded state] when data is getting successfully",
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTRivia));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        LoadedState(numberTrivial: tNumberTRivia)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForRandomNumber());
    });

    test(
        "should emit [loading state , Error state] when data is getting Unsuccessfully With Server ",
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: ErrorMessageConst.SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetTriviaForRandomNumber());
    });
  }

  group("getTriviaForRandomNumber", () {
    testGetNumberTriviaForRandomNumber();
  });
}
