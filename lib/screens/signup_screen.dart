import 'package:flutter/material.dart';
import 'package:loja_informatica/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _addresscepController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _celularController = TextEditingController();
 

  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,   
      ),
      body: ScopedModelDescendant<UserModel>(

        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(15.0) ,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText:"Nome Completo" 
              ),
              
              validator: (text){
                if(text.isEmpty ) return "Digite nome valido";   
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText:"E-mail" 
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty || !text.contains("@")) return "E-mail invalido";   
              },
            ),
            SizedBox(height: 16.0,),
              TextFormField(
                controller: _passController,
              decoration: InputDecoration(
                hintText:"Senha" 
              ),
              obscureText: true,
              validator: (text){
                if(text.isEmpty || text.length < 6) return "Digite uma senha valida";
              },
            ),
            
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText:"Endereço" 
              ),
              validator: (text){
                if(text.isEmpty)  return "Digite um endereço valido";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _addresscepController,
              decoration: InputDecoration(
                hintText:"CEP" 
              ),
              validator: (text){
                if(text.isEmpty)  return "Digite um Cep valido";
              },
            ),
            SizedBox(height: 16.0,),
             TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(
                hintText:"Telefone" 
              ),
              validator: (text){
                if(text.isEmpty)  return "Digite o telefone valido";
              },
            ),
           // SizedBox(height: 16.0,),
           /* TextFormField(
              controller: _celularController
              decoration: InputDecoration(
                hintText:"Celular"
              ),
              validator: (text){
                if(text.isEmpty)  return "Digite numero celular valido";
              },
            ),*/
            SizedBox(height: 19.0,),
           SizedBox(
             height: 44.0,
             child:  RaisedButton(
              child: Text("Criar Conta",
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                if(_formkey.currentState.validate()){

                  Map<String,dynamic> userData = {
                    "name": _nameController.text,
                    "email": _emailController.text,
                    "address": _addressController.text
                    
                  };


                  model.signUp(
                    userData: userData,
                    pass: _passController.text,
                    onSuccess: _onSuccess,
                    onFail: _onFail 
                  );
                }

              },
            ) ,
           ),
          ],
        ),
      );
        },
      )

    );
  }

  void _onSuccess(){
    _scaffoldkey.currentState.showSnackBar(
      SnackBar(content: Text("Usuario criado com sucesso"),
        backgroundColor:Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
          )
        );
        Future.delayed(Duration(seconds: 2)).then((_){
          Navigator.of(context).pop();
        });
  }

  void _onFail(){
     _scaffoldkey.currentState.showSnackBar(
      SnackBar(content: Text("Usuario nao foi criado"),
        backgroundColor:Colors.redAccent,
        duration: Duration(seconds: 2),
          )
        );
  }



}


