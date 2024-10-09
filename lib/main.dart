import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(),
    );
  }
}

// Define Product model
class Product {
  final String name;
  final String description;
  final double price;
  final int rating;
  final Color color;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.color,
  });
}

class ProductListPage extends StatelessWidget {
  // List of Products
  final List<Product> products = [
    Product(
      name: 'Pixel 1',
      description: 'Pixel is the most beautiful phone ever',
      price: 800,
      rating: 5,
      color: Colors.blueAccent,
    ),
    Product(
      name: 'Laptop',
      description: 'Laptop is the most productive development tool',
      price: 2000,
      rating: 4,
      color: Colors.green,
    ),
    Product(
      name: 'Tablet',
      description: 'Tablet is the most useful device ever for meetings',
      price: 1000,
      rating: 3,
      color: Colors.yellow,
    ),
    Product(
      name: 'Pendrive',
      description: 'Pendrive is the most portable storage device',
      price: 100,
      rating: 2,
      color: Colors.red,
    ),
    Product(
      name: 'Floppy Disk',
      description: 'Floppy disk is the most resilient storage device',
      price: 20,
      rating: 1,
      color: Colors.brown,
    ),
  ];

  // Method to build star rating
  Widget buildStarRating(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: Colors.orange,
        size: 16.0,
      ));
    }
    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Navigation'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to product details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: products[index]),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Colored card on the left
                    Container(
                      width: 100,
                      height: 100,
                      color: products[index].color,
                      child: Center(
                        child: Text(
                          products[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Spacing between the card and content

                    // Product content on the right
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Price: \$${products[index].price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          buildStarRating(products[index].rating), // Star rating under the price
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  // Method to build star rating
  Widget buildStarRating(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: Colors.orange,
        size: 24.0,
      ));
    }
    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to product list page
          },
        ),
      ),
      body: Column(
        children: [
          // Colored card at the top
          Container(
            width: double.infinity, // Full width
            color: product.color, // Use the product color
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                // Removed star rating from the colored card
              ],
            ),
          ),
          SizedBox(height: 20), // Spacing between the colored card and content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.description,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Price: \$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20), // Spacing before the star rating
                // Star rating appears only here
                buildStarRating(product.rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
