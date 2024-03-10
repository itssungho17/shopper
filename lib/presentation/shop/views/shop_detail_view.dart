import 'package:flutter/material.dart';
import 'package:shopper/presentation/shop/viewmodels/shop_detail_viewmodel.dart';
import 'package:shopper/presentation/shop/views/shop_detail_image_view.dart';

class ShopDetailView extends StatefulWidget {
  final int id;

  const ShopDetailView({required this.id, super.key});

  @override
  State<ShopDetailView> createState() => _ShopDetailViewState();
}

class _ShopDetailViewState extends State<ShopDetailView> {
  late ShopDetailViewModel _vm;
  late int _id;

  @override
  void initState() {
    _vm = ShopDetailViewModel();
    _id = widget.id;

    super.initState();
    startFetching();
  }

  void startFetching() {
    _vm.getProductById(_id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: ValueListenableBuilder(
                  valueListenable: _vm.product,
                  builder: (context, product, child) => Center(
                      child: Column(children: [
                    Text('${product?.id ?? ''}',
                        style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 4),
                    Text(product?.title ?? "",
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(product?.brand ?? "",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    Text(product?.description ?? "",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: product?.images.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: ((context, index) {
                          if (product == null) {
                            return const CircularProgressIndicator(
                              color: Colors.cyan,
                            );
                          } else {
                            final imageUrl = product.images[index];

                            return MaterialButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopDetailImageView(
                                        title: product.title,
                                        imageUrl: imageUrl)),
                              ),
                              child: Image.network(imageUrl),
                            );
                          }
                        })),
                  ])),
                )),
            ValueListenableBuilder(
                valueListenable: _vm.isLoading,
                builder: (context, isLoading, child) => Visibility(
                    visible: isLoading,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                    ))),
            Positioned(
                top: 0,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )),
            Positioned(
                top: 0,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.refresh, size: 30, color: Colors.cyan),
                  onPressed: () => startFetching(),
                ))
          ],
        ),
      ),
    );
  }
}
