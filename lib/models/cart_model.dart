import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_informatica/datas/cart_product.dart';
import 'package:loja_informatica/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CartModel extends Model{
  UserModel user;
  
  List<CartProduct> products = [];

  String couponCode;
  int  discountPercentage = 0; // aqui int antes 05/05/2019 alterçao

  bool isLoading = false;
  
  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
    ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").add(cartProduct.toMap()).then((doc){
          cartProduct.cid = doc.documentID;

      });

      notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();

  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }
  
  void updatePrices(){
    notifyListeners();
  }

  double getProductsPrice(){
     double price = 0.00;
    for(CartProduct c in products){
      if(c.productData != null)
        price += c.quantity * c.productData.price;
    }
    return price;


  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
   
  }

  double getShipPrice(){
    return 12.99;
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();                                                      
    
    double productPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientId":user.firebaseUser.uid,
        "products":products.map((CartProduct)=>CartProduct.toMap()).toList(),
        "shipPrice":shipPrice,
        "productsPrice": productPrice,
        "discount": discount,
        "totalPrice":productPrice - discount + shipPrice,
        "status": 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("orders").document(refOrder.documentID).setData(
        {
          "orderId": refOrder.documentID
        }
      );


      QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").getDocuments();

      for(DocumentSnapshot doc in query.documents){
        doc.reference.delete();
      }

      products.clear();
      couponCode = null;
      discountPercentage = 0;

      isLoading = false;
      notifyListeners();

      return refOrder.documentID;


  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
      .getDocuments();

      products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

      notifyListeners();
  }
}

