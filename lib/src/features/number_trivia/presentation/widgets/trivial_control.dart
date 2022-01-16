import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;
  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            validator: (value) {
              if(value.isEmpty ){
                return "the number is empty";
              }
            },
            onFieldSubmitted: (_) {
              dispatchConcrete();
            },
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text('Search'),
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.primary,
                  onPressed: dispatchConcrete,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RaisedButton(
                  child: Text('Get random trivia'),
                  onPressed: dispatchRandom,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
   if(_formkey.currentState.validate()){
     controller.clear();
     BlocProvider.of<NumberTriviaBloc>(context)
         .add(GetTriviaForConcreteNumber(inputStr));
   }
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
