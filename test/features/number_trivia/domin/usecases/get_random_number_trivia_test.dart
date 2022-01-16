
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/src/core/usecases/usecase.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/src/features/number_trivia/domain/repositores/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main(){
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetRandomNumberTrivia  usecases;

  setUp((){
    mockNumberTriviaRepository=MockNumberTriviaRepository();
    usecases =GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia=NumberTrivial(text: "test", number: 1);

  test("should get random trivia for the number from repository", () async{
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((_)async =>Right(tNumberTrivia));
    ///////act//////
    final result=await usecases(NoParams());
    //assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);


  });

}