import 'package:flutter/material.dart';

// Cart Item Model
class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

// Cart Service (Singleton)
class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(String id, String name, double price, String imageUrl, int quantity) {
    // Check if item already exists in cart
    final existingIndex = _items.indexWhere((item) => item.id == id);
    
    if (existingIndex != -1) {
      // Item exists, update quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // New item, add to cart
      _items.add(CartItem(
        id: id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        quantity: quantity,
      ));
    }
    
    notifyListeners();
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount => _items.length;
}