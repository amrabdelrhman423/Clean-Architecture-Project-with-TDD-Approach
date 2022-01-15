import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/constants/keys_constans.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{
}

void main(){
  NumberTriviaLocalDataSourceImp dataSource ;
  MockSharedPreferences mockSharedPreferences;
  
  setUp((){
    mockSharedPreferences=MockSharedPreferences();
    dataSource=NumberTriviaLocalDataSourceImp(sharedPreferences: mockSharedPreferences);
  });


  group("get Last Number Cached", (){
    final tNumberTriviaModel=NumberTrivialModel.fromJson(json.decode(fixture("trivia_cached.json")));
    test("should return Number TrivialModel from SharedPreferences when there is one in the cache", ()async{
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture("trivia_cached.json"));
      //act
      final result =await dataSource.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(KeysConstants.CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });
    test("should return Cache Exception When there is not a cached value", ()async{
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;
      //assert
      expect(()=>call(), throwsA( const TypeMatcher<CacheExceptions>()));
    });

  });



  group("set Cached Number Trivia", (){
    final tNumberTriviaModel=NumberTrivialModel(number:1 ,text: "test trivia");
    test("should Cached NumberTriviaJson in SharedPreferences", ()async{
      //act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);
      final expextedJsonString=json.encode(tNumberTriviaModel.toJson());
      //assert
      verify(mockSharedPreferences.setString(KeysConstants.CACHED_NUMBER_TRIVIA,expextedJsonString));
    });


  });
}