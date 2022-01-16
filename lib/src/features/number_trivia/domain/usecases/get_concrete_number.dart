import 'package:dartz/dartz.dart';
import 'package:tdd/src/core/error/failures.dart';
import 'package:tdd/src/core/usecases/usecase.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/src/features/number_trivia/domain/repositores/number_trivia_repository.dart';

class GetConCreteNumberTrivia implements UseCase<NumberTrivial, Params> {
  final NumberTriviaRepository repository;
  GetConCreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivial>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}
