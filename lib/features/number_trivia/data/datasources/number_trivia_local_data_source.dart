import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddcleanarchitecturecourse/core/error/exceptions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(CACHED_NUMBER_TRIVIA,
        jsonEncode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if(jsonString != null) {
      return Future.value(
          NumberTriviaModel.fromJson( json.decode( jsonString ) ) );
    } else {
      throw CacheException();
    }
  }

}
