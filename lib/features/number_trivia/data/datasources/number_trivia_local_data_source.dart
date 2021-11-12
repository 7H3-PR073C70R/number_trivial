import 'dart:convert';

import 'package:flutter_clean_architecture_tdd/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten that last time
  /// the user had an internet connection
  /// 
  /// Throws [CacheException] if no cached data was present
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cachedNumberTrivia(NumberTriviaModel triviaToCache);
}

const cachedNumberTrivialKey = 'trivia_cached.json';
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivialKey);
    if(jsonString != null) {
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }
    throw CachedException();
  }
  
  @override
  Future<void> cachedNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(cachedNumberTrivialKey, json.encode(triviaToCache.toJson()));
  }

}