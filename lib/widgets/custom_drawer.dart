import 'package:flutter/material.dart';
import 'package:loja_informatica/models/user_model.dart';
import 'package:loja_informatica/screens/login_screen.dart';
import 'package:loja_informatica/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';


class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);



  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          color: Colors.blue[200]
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0,top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0,8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Tech Tudo\n Express",
                        style: TextStyle(fontSize:34.0,fontWeight: FontWeight.bold , color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context,child,model){
                          return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Ola,${!model.isLoggedIn() ? "" : model.userData["name"]}",
                          
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold, color: Colors.white                      
                          ),
                          ),
                          GestureDetector(
                            child: Text(
                               (!model.isLoggedIn())?
                            "Entre ou cadastra-se "
                            :"Sair",
                            style: TextStyle(
                             color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap:(){
                            if(!model.isLoggedIn())
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>LoginScreen())
                              );
                            else
                              model.signOut();
                          },
                          )
                        ],
                      );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Minha Pagina',pageController,0),
              DrawerTile(Icons.list, 'Produtos',pageController,1),
              DrawerTile(Icons.location_on, 'Localizaçao das Lojas',pageController,2),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos',pageController,3),
              DrawerTile(Icons.favorite,'Favoritos', pageController,4),
              DrawerTile(Icons.settings, 'Configuraçoes', pageController,5)
            ] ,
          )
        ],
      ),
    );
  }
}
