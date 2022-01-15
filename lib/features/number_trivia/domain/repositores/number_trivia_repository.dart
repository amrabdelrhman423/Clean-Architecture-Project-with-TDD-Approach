import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository{
  Future<Either<Failure,NumberTrivial>>  getConcreteNumberTrivia(int number);
  Future<Either<Failure,NumberTrivial>>  getRandomNumberTrivia();
}