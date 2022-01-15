import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/core/utils/input_converter.dart';


void main(){
  InputConverter inputConverter;
  
  setUp((){
    inputConverter=InputConverter();
  });
  
  group("stringToUnSignedInt", (){
    test("input String convert to integer return integer", (){
      //arrange
      final str="5";
      //act
      final result=inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Right(5));
    });

    test("should return a Failure when the  input string is not integer", ()async{
      //arrange
      final str="not integer";
      //act
      final result=inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test("should return a Failure when the input is negative integer", ()async{
      //arrange
      final str="-5";
      //act
      final result=inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
});
}