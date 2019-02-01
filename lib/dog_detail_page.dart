import 'dog_model.dart';
import 'package:flutter/material.dart';

class DogDetailPage extends StatefulWidget {
  final Dog dog;
  //The dog that gets passed to here
  DogDetailPage(this.dog);
  //Change the Theme
  
  @override
  _DogDetailPageState createState() => _DogDetailPageState();
}


class _DogDetailPageState extends State<DogDetailPage> {
  final double dogAvatarSize = 150.0;

  //for slider and Button
  double _sliderValue = 10.0;

  Widget get addYourRating{
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // In a row, column, listview, etc., a Flexible widget is a wrapper
              // that works much like CSS's flex-grow property.
              //
              // Any room left over in the main axis after
              // the widgets are given their width
              // will be distributed to all the flexible widgets
              // at a ratio based on the flex property you pass in.
              // Because this is the only Flexible widget,
              // it will take up all the extra space.
              //
              // In other words, it will expand as much as it can until
              // the all the space is taken up.
              Flexible(
                flex: 1,
                // A slider, like many form elements, needs to know its
                // own value and how to update that value.
                //
                // The slider will call onChanged whenever the value
                // changes. But it will only repaint when its value property
                // changes in the state using setState.
                //
                // The workflow is:
                // 1. User drags the slider.
                // 2. onChanged is called.
                // 3. The callback in onChanged sets the sliderValue state.
                // 4. Flutter repaints everything that relies on sliderValue,
                // in this case, just the slider at its new value.
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  divisions: 15,
                  onChanged: (newRating) => setState(()=> _sliderValue = newRating),
                  value: _sliderValue,
                ),
              ),
              Container(
                
                width: 50.0,
                alignment: Alignment.center,
                
                child: Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1.apply(color: Colors.indigoAccent))
                
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }
  //A simple button
  Widget get submitRatingButton{
    return RaisedButton(
      onPressed: updateRating,
      child: Text('Submit'),
      color: Colors.indigoAccent,
      );
  }

  Widget get dogImage{
    return Hero(
    //Same code except the dog property is now accessible here as a widget
    tag: widget.dog,
     //Containers define the size of their children
    child: Container(
      height: dogAvatarSize,
      width: dogAvatarSize,
      //Decorate it like in CSS and like with the gradient
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          //Takes 4 properties similiar to CSS
          const BoxShadow(
            offset: const Offset(1.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: -1.0,
            color: const Color(0x33000000)
          ),
          const BoxShadow(
              offset: const Offset(2.0, 1.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
              color: const Color(0x24000000)),
          const BoxShadow(
              offset: const Offset(3.0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              color: const Color(0x1F000000)),
        ],
        //Add image to the background of entire container
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.dog.imageUrl),
        ),
      ),
    )
    );
  }

  Widget get rating{
    //Using a row layout for linear alignemnt
    return Row(
      //Center the widgets on main axis
      //which is the horizontal axis since this is a ROW
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size:40.0,
        ),
        Text(' ${widget.dog.rating} /10',
        style: Theme.of(context).textTheme.display2,),
        
      ],
    );
  }

  Widget get dogProfile{
     return Container(
       padding: EdgeInsets.symmetric(vertical: 32.0),
       decoration: BoxDecoration(
         //TODO Make a widget from this
         gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1,0.5,0.7,0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
         ),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           dogImage,
           Text(
             '${widget.dog.name}',
             style: TextStyle(fontSize: 32.0),
           ),
           Text(
             widget.dog.location,
             style:TextStyle(fontSize: 20.0),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16.0),
             child: Text(widget.dog.description),
           ),
           rating
         ],
       ),
     );
  }
  
  //This needs to be async because it can return information when the user interacts
  Future<Null> _ratingErrorDialog() async{
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Error!'),
          content: Text("They're good dogs, Brant"),
          //This Action uses the Navigator(like with pages/Activities) to dismiss the dialog
          //This is the place to return data from the dialog
          actions: <Widget>[
            FlatButton(
              child: Text('Try Again'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }


  ///////////////////////////////////////////////////////////////
  //Finally, the build method:
  //
  // Aside:
  // It's often much easier to build UI if you break up your widgets the way I
  // have in this file rather than trying to have one massive build method
  @override
  Widget build(BuildContext context) {
    //A new page means a new scaffold
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: <Widget>[
          dogProfile,addYourRating
        ],
      ),
    );
  }

  void updateRating(){
    if(_sliderValue < 10){
      _ratingErrorDialog();
    }else{
      setState(() {
          widget.dog.rating = _sliderValue.toInt();
      });
    }
    
  }
}