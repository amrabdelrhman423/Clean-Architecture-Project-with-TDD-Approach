import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NumberTrivial extends Equatable{
  final String text;
  final int number;
  NumberTrivial({
   @required this.text,
   @required this.number}):super([text,number]);

}