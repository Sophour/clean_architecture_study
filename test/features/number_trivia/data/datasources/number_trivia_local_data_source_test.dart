import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddcleanarchitecturecourse/core/error/exceptions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockedSharedPreferences extends Mock
    implements SharedPreferences{}

void main(){
  NumberTriviaLocalDataSourceImpl dataSource;
  MockedSharedPreferences mockedSharedPreferences;

  setUp((){
    mockedSharedPreferences = MockedSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockedSharedPreferences);
  });
  
  group('getLastNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
            ()async{
     // arrange
     when(mockedSharedPreferences.getString(any))
     .thenReturn(fixture('trivia_cached.json'));
     // act
              final result = await dataSource.getLastNumberTrivia();
              //assert
              verify(mockedSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
              expect(result, equals(tNumberTriviaModel));
    });


    test(
        'should throw CacheException when there is no cached value',
            ()async{
          // arrange
          when(mockedSharedPreferences.getString(any))
              .thenReturn(null);
          // act
          final call = dataSource.getLastNumberTrivia;
          //assert
          
          expect(() => call(), throwsA(matcher.TypeMatcher<CacheException>()));
        });
  });

  group('cacheNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test trivia');

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockedSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));

    });
  });
}