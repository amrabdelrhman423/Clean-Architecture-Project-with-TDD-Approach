import 'package:dartz/dartz.dart';
import 'package:tdd/src/core/error/failures.dart';

class InputConverter{

  Either<Failure,int> stringToUnsignedInteger(String str){
    try{
      final integer=int.parse(str);
      _checkIsPositiveNumber(integer);
      return Right(int.parse(str));
    }on FormatException{
      return Left(InvalidInputFailure());
    }
  }

   _checkIsPositiveNumber(int number){
    if(number<0)throw const FormatException();
  }
}

class InvalidInputFailure extends Failure{
}