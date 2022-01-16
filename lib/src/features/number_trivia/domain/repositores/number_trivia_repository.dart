import 'package:dartz/dartz.dart';
import 'package:tdd/src/core/error/failures.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository{
  Future<Either<Failure,NumberTrivial>>  getConcreteNumberTrivia(int number);
  Future<Either<Failure,NumberTrivial>>  getRandomNumberTrivia();
}