import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tddcleanarchitecturecourse/core/error/failures.dart';
import 'package:tddcleanarchitecturecourse/core/usecases/usecase.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:meta/meta.dart';


class GetConcreteNumberTrivia implements UseCase{
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(params) async {

    return await repository.getConcreteNumberTrivia(params.number);
  }



}

/// In the R; tutorial we wrapped th arguments with Params because
///
class Params extends Equatable{
  Params({@required this.number}) : super([number]);

  final int number;

}