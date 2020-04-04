import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable{
  NumberTriviaState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  Loaded({@required this.trivia}) : super ([trivia]);

  final NumberTrivia trivia;
}

class Error extends NumberTriviaState {
  Error({@required this.message}) : super ([message]);

  final String message;
}
