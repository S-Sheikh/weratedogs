import 'dart:convert';
import 'dart:io';

class Dog {
  //Dog name
  final String name;
  final String location;
  //Words about doggo
  final String description;
  //doggo picture
  String imageUrl;
  //Brant pls
  int rating = 10;
  //This is a constructor,final variables need to be intialized
  Dog(this.name,this.location,this.description);

  //Future need for async programming in Dart
  Future getImageUrl() async{
    //Null check incase that we already have a doggo image
    if(imageUrl != null){
      //If there is already an image , STOP DOING WORK...
      return;
    }
    //This is Darts built in HTTP bot or something
    //Uses the IO Package
    HttpClient http = HttpClient();
    //Like with FileStreams ... TryCatch because error prone
    try {
      //Uri Builder
      var uri = Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      //The api from dog.ceo will return a JSON object so we need to deserialize or decode it
      //JSON object will have prop -> 'message' that constains the imageUrl
      imageUrl = json.decode(responseBody)/*by this point we have access to the JSON object
      and can use it as normal*/['message'];
      
    } catch (e) {print(e);
    }
  }
}

