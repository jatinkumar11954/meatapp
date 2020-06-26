import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
var catgry = {
    0: "CHICKEN",
    1: "MUTTON",
    2: "SEA FOOD",
    3: "EGGS",
    4: "DEALS",
  };
  
    static var chicken = {
    0: "ChickenCurryLeg",
    1: "ChickenCurry",
    2: "ChickenLeg",
    3: "Chicken65",
  };
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productProvider = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      bottomNavigationBar: bottomBar(context, 1),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: ( _ , i) {
                  return   Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                                '\$${cart.items.values.toList()[i].price}'),
                          ),
                        ),
                      ),
                      title: Text(cart.items.values.toList()[i].title),
                      subtitle: Text(
                          'Total: \$${(cart.items.values.toList()[i].price * cart.items.values.toList()[i].quantity)}'),
                      trailing: SizedBox(

                          width: 120,
                          child:
                              // Row(children: <Widget>[Text("hai")],))
                              Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.remove_circle,color:Theme.of(context).primaryColor),
                                    onPressed: () {
                                        if (cart.items.values
                                              .toList()[i]
                                              .quantity ==
                                          1) {
                                        productProvider.subQuant(
                                            cart.items.values
                                                .toList()[i]
                                                .catName,
                                            cart.items.values
                                                .toList()[i]
                                                .column);
                                        cart.removeItem(
                                            cart.items.values.toList()[i].id);
           

                                        print(cart.items.length);
                                      }
                                      productProvider.subQuant(
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);
                                      cart.reduceQuant(
                                          cart.items.values.toList()[i].id,
                                          cart.items.values.toList()[i].price,
                                          cart.items.values.toList()[i].title,
                                              cart.items.values.toList()[i].img,
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);

                                    }),
                                Text(cart.items.values
                                    .toList()[i]
                                    .quantity
                                    .toString(),style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                IconButton(
                                    icon: Icon(Icons.add_circle,color:Theme.of(context).primaryColor),
                                    onPressed: () {
                                      productProvider.addQuant(
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);
                                      cart.addItem(
                                          cart.items.values.toList()[i].id,
                                          cart.items.values.toList()[i].price,
                                          cart.items.values.toList()[i].title,
                                                                                        cart.items.values.toList()[i].img,

                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);},),],),),)
                                  
                  ))
                         );
                }),
          )
        ],
      ),
    );
  }
}
