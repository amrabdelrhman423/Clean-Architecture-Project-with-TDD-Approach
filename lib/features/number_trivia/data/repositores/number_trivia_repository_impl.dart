import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/network/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositores/number_trivia_repository.dart';

typedef Future<NumberTrivial> _ConcretOrRandomChoose();

class NumberTriviaRepositoryImp implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImp(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivial>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivial(() => remoteDataSource.getConcreteNumberTrivia(number));

  }

  @override
  Future<Either<Failure, NumberTrivial>> getRandomNumberTrivia() async {
    return await _getTrivial(() => remoteDataSource.getRandomNumberTrivia());
  }
  Future<Either<Failure, NumberTrivial>> _getTrivial(
      _ConcretOrRandomChoose getConcreteOrRandom
      )async{
    // networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomTrivial =
            await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteRandomTrivial);
        return Right(remoteRandomTrivial);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivial = await localDataSource.getLastNumberTrivia();
        Right(localTrivial);
      } on CacheExceptions {
        return Left(CacheFailure());
      }
    }
  }

}
