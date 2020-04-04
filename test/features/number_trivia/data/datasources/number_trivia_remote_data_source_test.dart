import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddcleanarchitecturecourse/core/error/exceptions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock
implements http.Client{}


void main(){
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  void setUpMockHttpClientSuccess200(){
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }
  void setUpMockHttpClientFailure404(){
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', (){
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform GET request on a URL with 
    number being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      unawaited(dataSource.getConcreteNumberTrivia(tNumber));
      //assert
      verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
      headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response is 404 or not other (not 200)', () async{
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getConcreteNumberTrivia;
      // assert
      expect(()=>call(tNumber), throwsA(matcher.TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', (){
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform GET request on a URL with the endpoint 
    for random numbers and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      unawaited(dataSource.getRandomNumberTrivia());
      //assert
      verify(mockHttpClient.get('http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response is 404 or not other (not 200)', () async{
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(()=>call(), throwsA(matcher.TypeMatcher<ServerException>()));
    });
  });
}