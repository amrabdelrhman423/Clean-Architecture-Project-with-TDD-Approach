import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/network/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd/features/number_trivia/data/repositores/number_trivia_repository_impl.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImp repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImp(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel =
    NumberTrivialModel(text: "test trivia", number: tNumber);
    final NumberTrivial tNumberTrivial = tNumberTriviaModel;
    test("Should check if the device connected Network", () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            final result = await repository.getConcreteNumberTrivia(tNumber);
            //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            expect(result, equals(Right(tNumberTrivial)));
          });
      test(
          "should return Cached the data locally when the call to remote data source is successfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            await repository.getConcreteNumberTrivia(tNumber);
            //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
          });

      test(
          "should return Server Failure the data locally when the call to remote data source is unsuccessfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                .thenThrow(ServerExceptions());
            //act
            final result = await repository.getConcreteNumberTrivia(tNumber);
            //assert
            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestOffline(() {
      test("should return Local number trivial if devices is offine ",
              () async {
            //arrange
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            await repository.getConcreteNumberTrivia(tNumber);
            //assert
            // verifyZeroInteractions(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.getLastNumberTrivia());
          });
      test(
          "should return Cache Failure the data Remotely when the call to local data source is unsuccessfully ",
              () async {
            //arrange
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheExceptions());
            //act
            final result = await repository.getConcreteNumberTrivia(tNumber);
            //assert
            verify(mockLocalDataSource.getLastNumberTrivia());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });
  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel =
    NumberTrivialModel(text: "test trivia", number: 123);
    final NumberTrivial tNumberTrivial = tNumberTriviaModel;
    test("Should check if the device connected Network", () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getRandomNumberTrivia();
      //assert
      verify(mockNetworkInfo.isConnected);
    });
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            final result = await repository.getRandomNumberTrivia();
            //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            expect(result, equals(Right(tNumberTrivial)));
          });
      test(
          "should return Cached the data locally when the call to remote data source is successfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            await repository.getRandomNumberTrivia();
            //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
          });

      test(
          "should return Server Failure the data locally when the call to remote data source is unsuccessfully",
              () async {
            //arrange
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenThrow(ServerExceptions());
            //act
            final result = await repository.getRandomNumberTrivia();
            //assert
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestOffline(() {
      test("should return Local number trivial if devices is offine ",
              () async {
            //arrange
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            //act
            await repository.getRandomNumberTrivia();
            //assert
            // verifyZeroInteractions(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            verify(mockLocalDataSource.getLastNumberTrivia());
          });
      test(
          "should return Cache Failure the data Remotely when the call to local data source is unsuccessfully ",
              () async {
            //arrange
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheExceptions());
            //act
            final result = await repository.getRandomNumberTrivia();
            //assert
            verify(mockLocalDataSource.getLastNumberTrivia());
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });
}
