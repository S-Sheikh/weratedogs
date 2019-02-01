import 'package:flutter/material.dart';

import 'dog_card.dart';
import 'dog_model.dart';

class DogList extends StatelessWidget {
  final List<Dog> doggos;
  DogList(this.doggos);
  

  //return a method that returns widgets
  //instead of returning a widget
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
  // A builder method almost always returns a ListView.
  // A ListView is a widget similar to Column or Row.
  // It knows whether it needs to be scrollable or not.
  // It has a constructor called builder, which it knows will
  // work with a List.

  ListView _buildList(context){
    return ListView.builder(
      //Have to manually make item count for the list
      itemCount: doggos.length,
      //A callback that will return a widget
      itemBuilder: (context,int){
        //A DogCard for each doggo in list
        return (DogCard(doggos[int]));
      },
    );
  }
}