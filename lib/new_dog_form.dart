import 'package:flutter/material.dart';
import 'dog_model.dart';


class AddDogFormPage extends StatefulWidget {
  @override
  _AddDogFormPageState createState() => _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  //One TextEditingController for each form input:
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
TextEditingController locationController = TextEditingController();

  bool _errorFlag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Dog'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                // Text Field is the basic input widget for Flutter.
                // It comes built in with a ton of great UI and
                // functionality, such as the labelText field you see below.
                child: TextField(
                  //Tell the textField which controller will be listenning 
                  //to it's inputs
                  controller: nameController,
                  //Need to have a controller and a onChanged listner
                  //onChanged callback triggered each time the text changes
                  //it will then pass value to controller
                  //
                  //Set the text of your controller to
                  //the next value.
                  onChanged: (val){
                    if(val.isEmpty){
                      setState(() {
                        _errorFlag = false;
                      });
                    }
                    // nameController.text = val;
                  },
                  decoration: InputDecoration(
                    errorText: _errorFlag ? null: 'oh no',
                    errorStyle: TextStyle(
                      decorationStyle: TextDecorationStyle.dotted
                    ),
                    labelText: "Name the Pup"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                // Text Field is the basic input widget for Flutter.
                // It comes built in with a ton of great UI and
                // functionality, such as the labelText field you see below.
                child: TextField(
                  controller: locationController,
                  // onChanged: (v)=> locationController.text = v,
                  decoration: InputDecoration(
                    labelText: "Pup's location",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: descriptionController,
                  //Everytime the text changes , set that value to
                  //the controller which we will then change
                  // onChanged: (v) => descriptionController.text = v,
                  decoration: InputDecoration(
                    labelText: 'All about the pup',
                  ),
                ),
              ),
              // A Strange situation
              // This section needs to know it's context
              // easiest way to pass a context is to use a builder method
              // wrapping the button in a builder exposes the context for use
              // TODO find a better way to this rather that a 'hack'
        
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context){
                    return RaisedButton(
                      onPressed: () {
                        submitPup(context);
                      },
                      color: Colors.indigoAccent,
                      child: Text('Submit Pup'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
         
      ),
    ); 
  }
  //This will need context because this will make use of 
  //of the Navigator class which always needs some context
  void submitPup(BuildContext context){
    //Firstly , we need to do some input validation
    //A dog needs a name , but may be location independat???,
    // so we'll only abandon the save if there's no name
    if(nameController.text.isEmpty){
      print('Dogs need names');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Pup needs name!'),
        )
      );
    }else{
      //Create a new dog with the info from the form
      var newDog = Dog(nameController.text, locationController.text, descriptionController.text);
      //pop the page into the stratospehere
      // and pass the new doggo back to the previous page just like 
      //with an activity and intent arguments
      Navigator.of(context).pop(newDog);
    } 
  }
}