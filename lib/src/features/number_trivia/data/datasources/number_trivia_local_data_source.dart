import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/src/config/constants/keys_constans.dart';
import 'package:tdd/src/core/error/exceptions.dart';
import 'package:tdd/src/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheExceptions] if no cached data is present.
  Future<NumberTrivialModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTrivialModel trivialToCache);
}

class NumberTriviaLocalDataSourceImp implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImp({@required this.sharedPreferences});

  @override
  Future<NumberTrivialModel> getLastNumberTrivia() async {
    final jsonString =
        sharedPreferences.getString(KeysConstants.CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      NumberTrivialModel numberTrivialModel =
          NumberTrivialModel.fromJson(json.decode(jsonString));
      return numberTrivialModel;
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTrivialModel trivialToCache) {
    return sharedPreferences.setString(KeysConstants.CACHED_NUMBER_TRIVIA,
        json.encode(trivialToCache.toJson()));
  }
}
