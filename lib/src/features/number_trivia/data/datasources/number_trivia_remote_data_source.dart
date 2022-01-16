import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tdd/src/core/error/exceptions.dart';
import 'package:tdd/src/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/src/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTrivialModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTrivialModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImp({@required this.client});
  @override
  Future<NumberTrivialModel> getConcreteNumberTrivia(int number) async {

    return _getNumberTrivial(url: 'http://numbersapi.com/$number');

  }

  @override
  Future<NumberTrivialModel> getRandomNumberTrivia() {
    return _getNumberTrivial(url: "http://numbersapi.com/random");

  }

  Future<NumberTrivialModel> _getNumberTrivial({@required String url})async{
    final response = await client.get(url,
        headers: {'Content-Type': 'application/json'});
    if(response.statusCode==200){
      return NumberTrivialModel.fromJson(json.decode(response.body));
    }else{
      throw ServerExceptions();
    }
  }

}
