import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  final symbol;
  final companyName;
  final document;
  final region;
  final price;
  Share(
      {this.symbol, this.companyName, this.document, this.region, this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text("Valor de ações", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                companyName,
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(document,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w300)),
              Text(region,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w300)),
              Text("Preço: ${price.toString()}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w300))
            ],
          )),
    );
  }
}
