import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:shimmer/shimmer.dart';

class ProductSearch extends SearchDelegate<String> {
   ProductSearch()
      : super(
          searchFieldLabel: "ProductSearch",
        );
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final res = subCatList
        .where((e) => e.item.toLowerCase().contains(query.toLowerCase()));

    return query.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: res.length,
              itemBuilder: (ctx, i) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 0.7, //extend the shadow
                            offset: Offset(
                              1.0, // Move to right 10  horizontally
                              -1.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ]),
                        child: GridTile(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                "http://via.placeholder.com/350x200", //testing

                                // res.toList()[i].img,
                            width: 350,
                            placeholder: (c, s) => Shimmer.fromColors(
                                baseColor: Colors.grey[400],
                                highlightColor: Colors.white,
                                child: Container(
                                  width: 350,
                                  color: Colors.grey,
                                )),
                          ),
                          footer: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GridTileBar(
                                  backgroundColor: Colors.white,
                                  title:
                                      // Text(
                                      // "Incididunt consequat anim minim ullamco est in dolore laborum sit nostrud in.",
                                      RichText(
                                          text: TextSpan(
                                    //   text:
                                    //   res.toList()[i].item.substring(  res.toList()[i].item.toLowerCase().indexOf(query),query.length),
                                    //   //  query.substring(0, query.length),
                                    //   style:TextStyle(
                                    //                             fontSize: 22, color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: res.toList()[i].item.substring(
                                            0,
                                            res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query)),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: res.toList()[i].item.substring(
                                            res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query),
                                            res
                                                    .toList()[i]
                                                    .item
                                                    .toLowerCase()
                                                    .indexOf(query) +
                                                query.length),
                                        //  query.substring(0, query.length),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: res.toList()[i].item.substring(res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query) +
                                            query.length),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                                  // ),                                    Text(

                                  //                         res.toList()[i] .item.replaceFirst(    res.toList()[i].item[0],
                                  //                                   res.toList()[i].item[0].toUpperCase()),
                                  //                         style: TextStyle(
                                  //                             fontSize: 22, color: Colors.black),
                                  //                       ),
                                  subtitle:
                                      // Text(
                                      //     "Incididunt consequat anim minim ullamco est in dolore laborum sit nostrud in.",
                                      //     style: TextStyle(color: Colors.black)),

                                      Text(res.toList()[i].pieces.toString(),
                                          style:
                                              TextStyle(color: Colors.black)),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(18, 0, 0, 14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Text(
                                      //     "Magna anim labore irure non labore incididunt exercitation.",
                                      //     softWrap: true,
                                      //     style: TextStyle(
                                      //       color: Colors.black45,
                                      //       fontSize: 18,
                                      //     )),
                                      Text(res.toList()[i].desc,
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 18,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 14),
                                          height: 34,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                                  "Weight: ${res.toList()[i].weight}",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400)))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("339 ",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )),
                                          Text(
                                              res.toList()[i].weight == null
                                                  ? " price"
                                                  : "  ${res.toList()[i].price}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 23,
                                              )),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        CustomRoute(
                            builder: (c) =>
                                Description(catName: res.toList()[i].catname),
                            settings: RouteSettings(arguments: i)),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container();
  }
}

    class StoreSearch extends SearchDelegate<String> {

   StoreSearch()
        : super(
            searchFieldLabel: "StoreSearch",
         );
  @override
  Widget buildLeading(BuildContext context) {
    return Hero(
      tag: "Storesearch",
      child: Material(
        child: IconButton(
          tooltip: 'Back',
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
          ),
          onPressed: () {
            //Take control back to previous page
            this.close(context, null);
          },
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
 
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final res = !query.isNotEmpty
        ? List<SubCategory>()
        : subCatList
            .where((e) => e.item.toLowerCase().contains(query.toLowerCase()));
     return query.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: res.length,
              itemBuilder: (ctx, i) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 0.7, //extend the shadow
                            offset: Offset(
                              1.0, // Move to right 10  horizontally
                              -1.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ]),
                        child: GridTile(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                "http://via.placeholder.com/350x200", //testing

                                // res.toList()[i].img,
                            width: 350,
                            placeholder: (c, s) => Shimmer.fromColors(
                                baseColor: Colors.grey[400],
                                highlightColor: Colors.white,
                                child: Container(
                                  width: 350,
                                  color: Colors.grey,
                                )),
                          ),
                          footer: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GridTileBar(
                                  backgroundColor: Colors.white,
                                  title:
                                      // Text(
                                      // "Incididunt consequat anim minim ullamco est in dolore laborum sit nostrud in.",
                                      RichText(
                                          text: TextSpan(
                                    //   text:
                                    //   res.toList()[i].item.substring(  res.toList()[i].item.toLowerCase().indexOf(query),query.length),
                                    //   //  query.substring(0, query.length),
                                    //   style:TextStyle(
                                    //                             fontSize: 22, color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: res.toList()[i].item.substring(
                                            0,
                                            res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query)),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: res.toList()[i].item.substring(
                                            res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query),
                                            res
                                                    .toList()[i]
                                                    .item
                                                    .toLowerCase()
                                                    .indexOf(query) +
                                                query.length),
                                        //  query.substring(0, query.length),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: res.toList()[i].item.substring(res
                                                .toList()[i]
                                                .item
                                                .toLowerCase()
                                                .indexOf(query) +
                                            query.length),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                                  // ),                                    Text(

                                  //                         res.toList()[i] .item.replaceFirst(    res.toList()[i].item[0],
                                  //                                   res.toList()[i].item[0].toUpperCase()),
                                  //                         style: TextStyle(
                                  //                             fontSize: 22, color: Colors.black),
                                  //                       ),
                                  subtitle:
                                      // Text(
                                      //     "Incididunt consequat anim minim ullamco est in dolore laborum sit nostrud in.",
                                      //     style: TextStyle(color: Colors.black)),

                                      Text(res.toList()[i].pieces.toString(),
                                          style:
                                              TextStyle(color: Colors.black)),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(18, 0, 0, 14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Text(
                                      //     "Magna anim labore irure non labore incididunt exercitation.",
                                      //     softWrap: true,
                                      //     style: TextStyle(
                                      //       color: Colors.black45,
                                      //       fontSize: 18,
                                      //     )),
                                      Text(res.toList()[i].desc,
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 18,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 14),
                                          height: 34,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                                  "Weight: ${res.toList()[i].weight}",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400)))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("339 ",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )),
                                          Text(
                                              res.toList()[i].weight == null
                                                  ? " price"
                                                  : "  ${res.toList()[i].price}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 23,
                                              )),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        CustomRoute(
                            builder: (c) =>
                                Description(catName: res.toList()[i].catname),
                            settings: RouteSettings(arguments: i)),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container();
  }
}
