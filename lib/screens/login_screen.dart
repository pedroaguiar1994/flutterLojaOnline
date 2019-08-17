import 'package:flutter/material.dart';
import 'package:loja_informatica/models/user_model.dart';
import 'package:loja_informatica/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar Conta ",
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>SignUpScreen())
              );
            } ,
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context,child, model){
          if(model.isLoading)
          return Center(child: CircularProgressIndicator(),);
          return  Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(15.0) ,
          children: <Widget>[
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
            Align(
              alignment: Alignment.centerRight ,
              child: FlatButton(
                onPressed:() { 
                  if(_emailController.text.isEmpty)
                    _scaffoldkey.currentState.showSnackBar(
                        SnackBar(content: Text("Insira seu e-mail para recuperaçao!"),
                          backgroundColor:Colors.redAccent,
                          duration: Duration(seconds: 2),
                            )
                          );
                        else{
                          model.recoverPass(_emailController.text);
                          _scaffoldkey.currentState.showSnackBar(
                              SnackBar(content: Text("Confira seu e-mail!"),
                                backgroundColor:Colors.blueAccent[300],
                                duration: Duration(seconds: 2),
                                  )
                                );
                        }

                },
                child: Text("Esqueci minha senha",
                  textAlign: TextAlign.right,
                ),
                padding:EdgeInsets.zero,
                ) ,
            ),
            SizedBox(height: 16.0,),
           SizedBox(
             height: 44.0,
             child:  RaisedButton(
              
              child: Text("Entrar",
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                if(_formkey.currentState.validate()){
                }
                model.signIn(
                  email: _emailController.text,
                  pass: _passController.text,
                  onSuccess: _onSuccess,
                  onFail: _onFail
                );
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
    Navigator.of(context).pop();
  }

  void _onFail(){
      _scaffoldkey.currentState.showSnackBar(
      SnackBar(content: Text("Falha ao Entrar"),
        backgroundColor:Colors.redAccent,
        duration: Duration(seconds: 2),
          )
        );
  }
}
