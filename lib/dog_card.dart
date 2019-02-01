import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_detail_page.dart';

class DogCard extends StatefulWidget {
  final Dog dog;
  DogCard(this.dog);
  
  @override
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog;
  _DogCardState(this.dog);
  @override
  Widget build(BuildContext context) {
    // Start with a container so we can add layout
    // and styling props
    return InkWell(
      onTap: showDogDetailPage,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Container(
      height: 115.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50.0,
            child: dogCard,
          ),
          Positioned(top: 7.5,child: dogImage,),

        ],
      ),
    ),
    ),
    );
  }

  //Builder method to create a new page
  showDogDetailPage() {
    // Navigator.of(context) accesses the current app's navigator.
  // Navigators can 'push' new routes onto the stack,
  // as well as pop routes off the stack.
  //
  // This is the easiest way to build a new page on the fly
  // and pass that page some state from the current page.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return DogDetailPage(dog);
        }
      )
    );
  }

  //Create the actual Card UI as a single widget that can be used over
  Widget get dogCard{
    // A new container
    return Container(
      width: 350.0,
      height: 115.0,
      
      child: Card(
        color: Colors.blueGrey,
        //Applies defined padding to all of the child elements of widgets or whatever we're calling them in this language because programming is totally not a thing that's holding back people that aren't native english speakers from becoming programmers despite whatever passion for programming they may. (stop thinking of outlier cases you dumbwit) 
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          //Makes the child widgets move top to bottom
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.dog.name,style: Theme.of(context).textTheme.headline,),
              Text(widget.dog.location,style: Theme.of(context).textTheme.subhead,),
              //After make a Column of Text , make a row
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                  ),
                  Text(': ${widget.dog.rating} / 10')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  // State classes run this method when the state is created.
  // You shouldn't do async work in initState, so we'll defer it
  // to another method.

  void initState(){
    super.initState();
    renderDogPic();
  }

  //we should rather make the model class fetch this
  void renderDogPic() async {
  //this makes the api call as per the uri built
    await dog.getImageUrl();
  //setState is a global call that tells flutter to refresh shit
  //you have to know when UI changes have to be made so that you know when to call this
    setState((){
      renderUrl = dog.imageUrl;
    });
  }

String renderUrl;

Widget get dogImage{
  var dogAvatar = Hero(
    tag: dog,
    
    child: Container(
      //height and width autofill by default so need to
    // be set explicitly
    width: 100.0,
    height: 100.0,
    //Used for styling the container
    decoration: BoxDecoration(
      //This will decorate in a box (circle/rect) shape
      shape: BoxShape.circle,
      image: DecorationImage(
        //this is apparently like css
        fit: BoxFit.cover,
        
        //Network image knows that image will take a while to load since it is pulled from net
        //may show a default image
        image: NetworkImage(renderUrl ??''),
         
      )
    ),
    )
  );

  var placeHolder = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black54,Colors.black,Colors.blueGrey[600]],
      )
    ),
    alignment: Alignment.center,
    child: Text('Doggo',textAlign: TextAlign.center,),
  );

  return AnimatedCrossFade(
    //pass the starting widget and the end widget
    firstChild: placeHolder,
    secondChild: dogAvatar,
    //Pass a ternary that should be based on your state
    //
    //
    //IF rederURL is null then widget should use placeholder,
    //otherwise use the doggoAvatar
    crossFadeState: renderUrl == null ? CrossFadeState.showFirst :CrossFadeState.showSecond,
    //pass the duration of the animation
    duration: Duration(milliseconds: 1500),
  );  
}
}



