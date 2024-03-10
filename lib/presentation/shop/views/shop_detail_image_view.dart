import 'package:flutter/material.dart';

class ShopDetailImageView extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ShopDetailImageView({
    required this.title,
    required this.imageUrl,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('$title', style: Theme.of(context).textTheme.titleMedium),
          backgroundColor: Colors.black38,
          elevation: 0,
        ),
        body: InteractiveViewer(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(imageUrl)
          )
        )
      ),
    );
  }
}
