
import 'dart:convert';

import 'package:flutter_clean_architecture_tdd/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/fixtures/fixture_reader.dart';
import '../../../../helper/mockito_helper.mocks.dart';

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () { 
    final tNumberTrivialModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test('should return number trivial model from sharedPreferences when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));

      // act
      final result = await dataSource.getLastNumberTrivia();

      // assert
      verify(mockSharedPreferences.getString(cachedNumberTrivialKey));
      expect(result, equals(tNumberTrivialModel));

    });

    test('should throw a ChachedException when there is no cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = dataSource.getLastNumberTrivia;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CachedException>()));

    });
  });

  group('cahcedNumberTrvial', () { 
    const tNumberTrivialModel = NumberTriviaModel(text: 'test trivia', number: 1);
    test('should call SharedPreferences to cahce the data', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async =>true);
      // act
      dataSource.cachedNumberTrivia(tNumberTrivialModel);
      // assert
      final exceptedJsonString = json.encode(tNumberTrivialModel.toJson());
      verify(mockSharedPreferences.setString(cachedNumberTrivialKey, exceptedJsonString));
    });
  });
}