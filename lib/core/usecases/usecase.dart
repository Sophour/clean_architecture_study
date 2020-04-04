import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tddcleanarchitecturecourse/core/error/failures.dart';

// TUTORIAL #3

// A template to follow throughout your entire app.
// So that you don't forget fow to name the main method in your class
// This is an interface in dart
abstract class UseCase<Type, Params>{

  Future<Either<Failure, Type>> call(Params params);
}

// Every class that extends UseCase will define its parameters
// on its own, each will contain this little separate class
// inside the same file
class NoParams extends Equatable{}