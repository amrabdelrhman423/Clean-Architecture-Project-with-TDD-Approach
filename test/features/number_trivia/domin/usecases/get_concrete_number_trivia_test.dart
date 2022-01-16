import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/src/core/usecases/usecase.dart';
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/src/features/number_trivia/domain/repositores/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_concrete_number.dart';
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {

}

void main(){
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetConCreteNumberTrivia  usecases;

  setUp((){
     mockNumberTriviaRepository=MockNumberTriviaRepository();
     usecases =GetConCreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber=1;
  final tNumberTrivia=NumberTrivial(text: "test", number: tNumber);

  test("description", () async{
    //arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any)).thenAnswer((_)async =>Right(tNumberTrivia));
    ///////act//////
    final result=await usecases(Params(number: tNumber));
    //assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);


  });

}