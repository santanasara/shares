import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ShareModel.dart';
import 'Share.dart';

const request = "https://api.hgbrasil.com/finance?key=1eb8b123";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.amber),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final shareController = TextEditingController();
  String symbol = '';
  bool isError = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<Map> getData(String symbol) async {
    http.Response response = await http.get(
        "https://api.hgbrasil.com/finance/stock_price?key=1eb8b123&symbol=bidi4");
    if (response.statusCode == 200) {
      // ignore: deprecated_member_use
      var list = new List();
      var responseData = json.decode(response.body)['results'];
      responseData.forEach((key, value) {
        list.add(value);
      });
      try {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Share(
                    symbol: list[0]['symbol'],
                    companyName: list[0]['company_name'],
                    document: list[0]['document'],
                    region: list[0]['region'],
                    price: list[0]['price'])));
      } on Exception catch (error) {
        print(error);
      }
    }
  }

  onChangeShare() {
    setState(() {
      symbol = shareController.value.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title:
                Text("Valor de ações", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Colors.deepOrangeAccent),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.trending_up,
                          size: 180, color: Colors.deepOrangeAccent),
                      Text(
                        "Ações da BOVESPA",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Consulte uma ação da BOVESPA",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        onChanged: onChangeShare(),
                        decoration: InputDecoration(
                            hintText: "exemplo: BIDI4",
                            hintStyle: TextStyle(color: Colors.grey),
                            labelText: "Símbolo",
                            labelStyle:
                                TextStyle(color: Colors.deepOrangeAccent),
                            border: OutlineInputBorder()),
                        style: TextStyle(
                            color: Colors.deepOrangeAccent, fontSize: 18),
                        controller: shareController,
                        validator: (value) {
                          if (value.isEmpty) return "Insira um símbolo!";
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton.icon(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              getData(symbol);
                            }
                          },
                          icon: Icon(Icons.search_rounded,
                              color: Colors.white, size: 25),
                          textColor: Colors.white,
                          color: Colors.deepOrangeAccent,
                          label: Text(
                            "Consultar",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ])),
          ),
        ));
  }
}
