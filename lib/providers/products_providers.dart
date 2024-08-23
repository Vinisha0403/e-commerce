import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/products.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p20',
      name: 'DANVOUY Womens T Shirt Casual Cotton Short',
      description:
          '95% cotton, 5% spandex. Casual short sleeve T-shirt with letter print, V-neck, soft and stretchy fabric.',
      price: 12.99,
      imageUrl: 'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
      category: "women's clothing",
      rating: Rating(
        rate: 3.6,
        count: 145,
      ),
    ),
    // Add more products here
    Product(
      id: 'p1',
      name: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      description:
          'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      price: 109.95,
      imageUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      category: "men's clothing",
      rating: Rating(
        rate: 3.9,
        count: 120,
      ),
    ),
    Product(
      id: 'p2',
      name: 'Mens Casual Premium Slim Fit T-Shirts',
      description:
          'Slim-fitting style, contrast raglan long sleeve, three-button henley placket, lightweight & soft fabric for breathable and comfortable wearing.',
      price: 22.3,
      imageUrl:
          'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
      category: "men's clothing",
      rating: Rating(
        rate: 4.1,
        count: 259,
      ),
    ),
    Product(
      id: 'p3',
      name: 'Mens Cotton Jacket',
      description:
          'Great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions such as working, hiking, camping, and more.',
      price: 55.99,
      imageUrl: 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
      category: "men's clothing",
      rating: Rating(
        rate: 4.7,
        count: 500,
      ),
    ),
    Product(
      id: 'p4',
      name: 'Mens Casual Slim Fit',
      description:
          'The color could be slightly different between on the screen and in practice. Please review the detailed size information below.',
      price: 15.99,
      imageUrl: 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',
      category: "men's clothing",
      rating: Rating(
        rate: 2.1,
        count: 430,
      ),
    ),
    Product(
      id: 'p5',
      name:
          'John Hardy Women\'s Legends Naga Gold & Silver Dragon Station Chain Bracelet',
      description:
          'Inspired by the mythical water dragon that protects the ocean\'s pearl. Wear facing inward for love and abundance, outward for protection.',
      price: 695,
      imageUrl:
          'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
      category: "jewelry",
      rating: Rating(
        rate: 4.6,
        count: 400,
      ),
    ),
    Product(
      id: 'p6',
      name: 'Solid Gold Petite Micropave',
      description:
          'Satisfaction guaranteed. Return or exchange any order within 30 days. Designed and sold by Hafeez Center in the United States.',
      price: 168,
      imageUrl:
          'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
      category: "jewelry",
      rating: Rating(
        rate: 3.9,
        count: 70,
      ),
    ),
    Product(
      id: 'p7',
      name: 'White Gold Plated Princess',
      description:
          'Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts for Engagement, Wedding, Anniversary, Valentine\'s Day.',
      price: 9.99,
      imageUrl:
          'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
      category: "jewelry",
      rating: Rating(
        rate: 3,
        count: 400,
      ),
    ),
    Product(
      id: 'p8',
      name: 'Pierced Owl Rose Gold Plated Stainless Steel Double',
      description:
          'Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel.',
      price: 10.99,
      imageUrl:
          'https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg',
      category: "jewelry",
      rating: Rating(
        rate: 1.9,
        count: 100,
      ),
    ),
    Product(
      id: 'p9',
      name: 'WD 2TB Elements Portable External Hard Drive - USB 3.0',
      description:
          'USB 3.0 and USB 2.0 Compatibility, fast data transfers, improve PC performance, high capacity.',
      price: 64,
      imageUrl: 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 3.3,
        count: 203,
      ),
    ),
    Product(
      id: 'p10',
      name: 'SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s',
      description:
          'Easy upgrade for faster boot up, shutdown, application load and response.',
      price: 109,
      imageUrl: 'https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 2.9,
        count: 470,
      ),
    ),
    Product(
      id: 'p11',
      name:
          'Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5',
      description:
          '3D NAND flash for high transfer speeds, remarkable transfer speeds that enable faster bootup and improved system performance.',
      price: 109,
      imageUrl: 'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 4.8,
        count: 319,
      ),
    ),
    Product(
      id: 'p12',
      name:
          'WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive',
      description:
          'Expand your PS4 gaming experience, Play anywhere Fast and easy setup. Sleek design with high capacity, 3-year manufacturer\'s limited warranty.',
      price: 114.00,
      imageUrl: 'https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 4.8,
        count: 400,
      ),
    ),
    Product(
      id: 'p13',
      name: 'Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin',
      description:
          '21.5 inches Full HD widescreen IPS display with Radeon FreeSync technology. No compatibility for VESA Mount.',
      price: 599.00,
      imageUrl: 'https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 2.9,
        count: 250,
      ),
    ),
    Product(
      id: 'p14',
      name: 'Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor',
      description:
          '49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27-inch screen side by side. Quantum dot technology, HDR support.',
      price: 999.99,
      imageUrl: 'https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',
      category: "electronics",
      rating: Rating(
        rate: 2.2,
        count: 140,
      ),
    ),
    Product(
      id: 'p15',
      name: 'BIYLACLESEN Women\'s 3-in-1 Snowboard Jacket Winter Coats',
      description:
          'Detachable liner fabric: warm fleece. Adjustable cuff to prevent the wind and water, 3 in 1 detachable design for different seasons.',
      price: 56.99,
      imageUrl: 'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
      category: "women\'s clothing",
      rating: Rating(
        rate: 2.6,
        count: 235,
      ),
    ),
    Product(
      id: 'p16',
      name:
          'Lock and Love Women\'s Removable Hooded Faux Leather Moto Biker Jacket',
      description:
          'Faux leather material for style and comfort. Features 2 pockets on the front, a removable hood, and detailed stitching at the sides.',
      price: 29.95,
      imageUrl: 'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
      category: "women\'s clothing",
      rating: Rating(
        rate: 2.9,
        count: 340,
      ),
    ),
    Product(
      id: 'p17',
      name: 'Rain Jacket Women Windbreaker Striped Climbing Raincoats',
      description:
          'Lightweight, perfect for casual wear. Features adjustable drawstring waist, button, and zipper front closure, with fully striped lining.',
      price: 39.99,
      imageUrl: 'https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg',
      category: "women\'s clothing",
      rating: Rating(
        rate: 3.8,
        count: 679,
      ),
    ),
    Product(
      id: 'p18',
      name: 'MBJ Women\'s Solid Short Sleeve Boat Neck V',
      description:
          'Lightweight fabric with great stretch for comfort. Ribbed on sleeves and neckline, double stitching on bottom hem.',
      price: 9.85,
      imageUrl: 'https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg',
      category: "women\'s clothing",
      rating: Rating(
        rate: 4.7,
        count: 130,
      ),
    ),
    Product(
      id: 'p19',
      name: 'Opna Women\'s Short Sleeve Moisture',
      description:
          '100% polyester, machine washable. Soft lightweight fabric with a comfortable V-neck collar and a slimmer fit.',
      price: 7.95,
      imageUrl: 'https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg',
      category: "women\'s clothing",
      rating: Rating(
        rate: 4.5,
        count: 146,
      ),
    )
  ];

  // Getter to return a copy of the products list
  List<Product> get items {
    return [..._items];
  }

  // Method to find a product by its ID
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> getSimilarProducts(String category) {
    return _items.where((product) => product.category == category).toList();
  }

  // Method to add a new product
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Notify listeners to refresh UI when products change
  }
}
