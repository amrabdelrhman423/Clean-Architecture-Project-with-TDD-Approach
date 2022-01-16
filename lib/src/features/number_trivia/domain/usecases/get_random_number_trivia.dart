
 import 'package:dartz/dartz.dart';
import 'package:tdd/src/core/error/failures.dart';
import 'package:tdd/src/core/usecases/usecase.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/src/features/number_trivia/domain/repositores/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivial,NoParams>{

  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivial>> call(NoParams) async{
  return  await repository.getRandomNumberTrivia();
  }

}

