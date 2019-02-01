import 'package:flutter/material.dart';
import 'dog_card.dart';
import 'dog_model.dart';
import 'dog_list.dart';
import 'new_dog_form.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We rate Dogs',
//      theme: ThemeData(brightness: Brightness.dark),

      home: MyHomePage(title:'We Rate Dogs'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,this.title}) : super(key:key);

  final String title;

  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.black87,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: 
            _showNewDogForm,
        )
      ],
    ),
    
    body: Container(
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: Center(
        child: DogList(initialDoggos),
      ),
    ),
  );
  }
  // Any time you're pushing a new route and expect that route
  // to return something back to you,
  // you need to use an async function.
  // In this case, the function will create a form page
  // which the user can fill out and submit.
  // On submission, the information in that form page
  // will be passed back to this function.
  Future _showNewDogForm() async{
    Dog newDog = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return AddDogFormPage();
        }
      ),
    );
    
    // A null check to make sure user hasn't submitted blank data
    if (newDog != null) {
      //if dog is ok then add it to our array
      initialDoggos.add(newDog);
    }
  }
}