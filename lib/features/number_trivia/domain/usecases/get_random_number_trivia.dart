import 'package:dartz/dartz.dart';
import 'package:tddcleanarchitecturecourse/core/error/failures.dart';
import 'package:tddcleanarchitecturecourse/core/usecases/usecase.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams>{
  GetRandomNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async{
    return await repository.getRandomNumberTrivia();
  }


}


