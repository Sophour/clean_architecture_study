import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';

abstract class State extends Equatable{}

class InitialState extends State{}

class LoadingState extends State{}

class LoadedState extends State{
  LoadedState( {@required this.numberTrivia} );

  final NumberTrivia numberTrivia;
}

class ErrorState extends State{
  ErrorState( {@required this.errorMsg} );

  final String errorMsg;
}