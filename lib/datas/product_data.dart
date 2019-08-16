import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

String category;
String id;
String title;
String description;
String size;

double price;
List images;
List sizes;


ProductData.fromDocument(DocumentSnapshot snapshot){
  id = snapshot.documentID;
  title = snapshot.data["title"];
  description = snapshot.data["description"];
  price = snapshot.data["price"];
  images = snapshot.data["images"]; 
  sizes = snapshot.data["sizes"];
  size = snapshot.data["size"];
  
  }

  Map<String, dynamic> toResumedMap(){
    return{
      "title": title,
      "description":description,
      "price": price
    };

  }

 
}