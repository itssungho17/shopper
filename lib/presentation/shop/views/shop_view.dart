import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:shopper/presentation/shop/viewmodels/shop_viewmodel.dart';
import 'package:shopper/presentation/shop/views/shop_detail_view.dart';
import 'package:shopper/domain/providers/auth_provider.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late ShopViewModel _vm;

  bool _isGrid = false;

  @override
  void initState() {
    _vm = ShopViewModel();
    super.initState();
    _vm.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    _vm.getProducts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('상점'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGrid = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _isGrid = false;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black38,
      body: Stack(children: [
        ValueListenableBuilder(
          valueListenable: _vm.products,
          builder: ((context, products, child) {
            return RefreshIndicator(
                color: Colors.cyan,
                backgroundColor: Colors.black54,
                onRefresh: () async {
                  _vm.getProducts();
                },
                child: _isGrid
                    ? _buildGridView(products)
                    : _buildListView(products));
          }),
        ),
        Visibility(visible: user == null, child: _buildWarningMsg(context)),
      ]),
    );
  }

  GridView _buildGridView(List<Product> products) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: ((context, index) {
          return MaterialButton(
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(products[index].title),
                subtitle: Text(products[index].brand),
              ),
              child: Image.network(products[index].images[0]),
            ),
            onPressed: () => onTap(context, products[index].id),
          );
        }));
  }

  ListView _buildListView(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
            tileColor: Colors.black54,
            title: Text(products[index].title),
            subtitle: Text(products[index].brand),
            leading:
                Image.network(products[index].images[0], width: 60, height: 60),
            onTap: () => onTap(context, products[index].id));
      },
    );
  }

  void onTap(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopDetailView(id: id)),
    );
  }

  Center _buildWarningMsg(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Spacer(),
        const Icon(Icons.warning, color: Colors.yellow, size: 80),
        const SizedBox(height: 16),
        Text('로그인이 필요한 서비스입니다.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white70, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        const Spacer(),
      ],
    ));
  }
}
