import 'package:flutter/material.dart';
import 'package:loja_informatica/models/cart_model.dart';
import 'package:loja_informatica/models/user_model.dart';
import 'package:loja_informatica/screens/home_screen.dart';
import 'package:loja_informatica/screens/login_screen.dart';
import 'package:loja_informatica/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context){
        return ScopedModel<UserModel>(
          model: UserModel(),
          child:ScopedModelDescendant<UserModel>(
            builder: (context,child, model){
              return  ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
          title: "Flutter´s Clothing",
          theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Color.fromARGB(255, 255, 127, 0)
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
          ),
            );
              }
                  ),
        );

      }
    }