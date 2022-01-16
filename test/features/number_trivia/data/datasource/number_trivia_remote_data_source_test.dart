import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/src/core/error/exceptions.dart';
import 'package:tdd/src/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/src/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClinet extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImp dataSource;
  MockHttpClinet mockHttpClinet;

  setUp(() {
    mockHttpClinet = MockHttpClinet();
    dataSource = NumberTriviaRemoteDataSourceImp(client: mockHttpClinet);
  });
  void setUpMockHttpClientSucess200() {
    when(mockHttpClinet.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
  }

  void setUpMockHttpClientUnSucess() {
    when(mockHttpClinet.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong ", 404));
  }

  void testGetConcreteData() {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTrivialModel.fromJson(json.decode(fixture("trivia.json")));
    test('''should perform a Get request in URL with number beging
     the endpoint and with application/json headers''', () async {
      //arrange
      setUpMockHttpClientSucess200();
      //act
      dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockHttpClinet.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });
    test("it should return NumberTrivia code is 200(success)", () async {
      //arrange
      setUpMockHttpClientSucess200(); //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        "it should throw Server EXception when code is 404 or Other(unsuccess)",
        () async {
      //arrange
      setUpMockHttpClientUnSucess();
      //act
      final call = dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerExceptions>()));
    });
  }

  void testGetRandomData() {
    final tNumberTriviaModel =
        NumberTrivialModel.fromJson(json.decode(fixture("trivia.json")));
    test('''should perform a Get request in URL with number beging
     the endpoint and with application/json headers''', () async {
      //arrange
      setUpMockHttpClientSucess200();
      //act
      dataSource.getRandomNumberTrivia();
      //assert
      verify(mockHttpClinet.get('http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'}));
    });
    test("it should return NumberTrivia code is 200(success)", () async {
      //arrange
      setUpMockHttpClientSucess200(); //act
      final result = await dataSource.getRandomNumberTrivia();
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        "it should throw Server EXception when code is 404 or Other(unsuccess)",
        () async {
      //arrange
      setUpMockHttpClientUnSucess();
      //act
      final call = dataSource.getRandomNumberTrivia;
      //assert
      expect(() => call(), throwsA(TypeMatcher<ServerExceptions>()));
    });
  }

  group("getConcreteNumberTrivia", () {
    testGetConcreteData();
  });

  group("getConcreteNumberTrivia", () {
    testGetRandomData();
  });
}
