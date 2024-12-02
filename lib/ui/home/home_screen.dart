
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination/ui/home/widgets/cart_widget.dart';

import '../../service/api_service.dart';
import '../../model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ProductModel> products = [];
  int page = 1;
  int limit = 10;


  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 250,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10
          ),
          itemCount: products.length+1,
          itemBuilder: (context, index) {
            if(index==products.length) {
              fetchData();
              return IconButton(
                onPressed: () => fetchData(),
                icon: Icon(Icons.refresh),
              );
            }
            return CartWidget(model: products[index]);
          },
        ),
      ),
    );
  }


  Future fetchData() async {
    Response? response =  await ApiService().GET(ApiService.PRODUCTS+"?page=$page&limit=$limit");
    List list = response!.data;
    products.addAll(list.map((e) => ProductModel.fromJson(e),).toList());
    page++;
    setState(() {});
  }

}
