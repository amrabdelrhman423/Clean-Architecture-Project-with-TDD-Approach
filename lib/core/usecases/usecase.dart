 import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tdd/core/error/failures.dart';

abstract class UseCase<Type,Params>{
   Future<Either<Failure,Type>> call(Params params);
 }

 class NoParams extends Equatable{}
 class Params extends Equatable{
   final int number;
   Params({@required this.number}):super([number]);
}