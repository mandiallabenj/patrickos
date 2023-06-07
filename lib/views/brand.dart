import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/brand.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {

  String url = "http://34.16.140.30/bdi/core/api/brands/1";

  late Future<Brand> futureBrand;

  Future<Brand> fetchBrand() async{
   final response = await http.get(Uri.parse(url));
   if(response.statusCode == 200){
     return Brand.fromJson(jsonDecode(response.body));
   }
   else{
     throw Exception('Unknown Error');
   }
  }



  @override
  void initState() {
    super.initState();
    futureBrand = fetchBrand();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patrickos App'),),
      body: Center(
        child: FutureBuilder(
            future: futureBrand,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text('Brand Details from Server'),
                    Row(
                      children: [
                        Text(snapshot.data!.id),
                        Text(
                          snapshot.data!.name == null? snapshot.data!.name : 'No Data',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
