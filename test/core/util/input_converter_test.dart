import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddcleanarchitecturecourse/core/util/input_converter.dart';

void main(){
  InputConverter inputConverter;
  
  setUp((){
    inputConverter = InputConverter();
  });
  
  group('stringToUnsignedInt', (){

    test(
        'should return an integer when a string represents an unsigned integer', () async {
     // arrange
     final str = '123';
     // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Right(123));
    });

    test(
        'should return a Failure when the string is not an integer', () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, equals(Left(InvalidInputFailure())));
    });

    test(
        'should return a Failure when the string is a negative integer', () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, equals(Left(InvalidInputFailure())));
    });
  });
}

