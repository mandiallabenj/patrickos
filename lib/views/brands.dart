import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patrickos/model/brand.dart';
class Brands extends StatefulWidget {
  const Brands({Key? key}) : super(key: key);
  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {

  List<Brand> parseBrands(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Brand>((json)=>Brand.fromJson(json)).toList();
  }

  Future<List<Brand>> fetchBrands(http.Client client) async {
    final response = await client.get(Uri.parse('http://34.16.140.30/bdi/core/api/brands/'));
    // return parseBrands(response.body);
    return compute(parseBrands, response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Brands'),),
      body: FutureBuilder<List<Brand>>(
        future: fetchBrands(http.Client()),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text('An Error'),
            );
          }else if(snapshot.hasData){
            return BrandList(brands: snapshot.data!,);
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class BrandList extends StatelessWidget {

  const BrandList({super.key, required this.brands});
  final List<Brand> brands;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: brands.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(Icons.tag) ,
            title: GestureDetector(
              onTap: (){

              },
              child: Text(brands[index].name),
            ),
          );
        },
     );
  }
}

