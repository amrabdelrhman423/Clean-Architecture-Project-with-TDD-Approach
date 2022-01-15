import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositores/number_trivia_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tNumberTriviaModel=NumberTrivialModel(number:1,text:"Test Text");

  test("should be a subclass of NumberTrivia entity", ()async{
    //arrange

    //act

    //assert
    expect(tNumberTriviaModel, isA<NumberTrivial>());
  });

  group("fromJson", (){

    test("should return a valid model when the Json is Integer ", ()async{
      //arrange
      final Map<String ,dynamic>jsonMap=json.decode(fixture('trivia.json'));
      //act
      final result=NumberTrivialModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test("should return a valid model when the Json is double number ", ()async{
      //arrange
      final Map<String ,dynamic>jsonMap=json.decode(fixture('trivia_double.json'));
      //act
      final result=NumberTrivialModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

  });

  group("toJson", (){

    test("should return a Json Map ", ()async{
      //act
      final result=tNumberTriviaModel.toJson();
      //assert
      final expexctedMap={
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expexctedMap);
    });
  });

}