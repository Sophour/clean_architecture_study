import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NumberTrivia extends Equatable{

  NumberTrivia({
    @required this.text,
    @required this.number,
  }) : super([text,number]);

  final String text;
  final int number;


}