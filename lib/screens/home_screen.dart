import 'package:flutter/material.dart';
import 'package:loja_informatica/tabs/home_tab.dart';
import 'package:loja_informatica/tabs/orders_tab.dart';
import 'package:loja_informatica/tabs/products_tab.dart';
import 'package:loja_informatica/widgets/cart_button.dart';
import 'package:loja_informatica/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {


  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:_pageController ,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body:HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton() ,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produto"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Container(color: Colors.yellow,),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
