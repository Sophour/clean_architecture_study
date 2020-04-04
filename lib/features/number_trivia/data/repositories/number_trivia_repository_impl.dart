import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tddcleanarchitecturecourse/core/error/exceptions.dart';
import 'package:tddcleanarchitecturecourse/core/error/failures.dart';
import 'package:tddcleanarchitecturecourse/core/network/network_info.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:pedantic/pedantic.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository{

  NumberTriviaRepositoryImplementation({
      @required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
   return await _getTrivia((){
     return remoteDataSource.getConcreteNumberTrivia(number);
   });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom
      ) async{

    if( await networkInfo.isConnected){
      try {
        final remoteTrivia = await getConcreteOrRandom();
        unawaited( localDataSource.cacheNumberTrivia( remoteTrivia ) );
        return Right( remoteTrivia );
      }
      on ServerException{
        return Left(ServerFailure());
      }
    } else{
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia( );
        return Right( localTrivia );
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}