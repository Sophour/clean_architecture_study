import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable{
  NumberTriviaEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  GetTriviaForConcreteNumber(this.numberString) : super([numberString]);

  final String numberString;
}

class GetTriviaForRandomNumber extends NumberTriviaEvent{}