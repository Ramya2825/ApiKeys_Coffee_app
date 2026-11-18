import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final Map<String, dynamic> coffee;

  const CartPage({super.key, required this.coffee});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
   List<Map<String, dynamic>> data = [];
  int quantity = 1;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> sendpostrequest() async {
    final coffee = widget.coffee;
    int price = coffee['price'];
    int total = price * quantity;

    final url = Uri.parse(
      'https://6adb0cc17512f497b300640f.mockapi.io/api/v1/bookings',
    );

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_name': nameController.text,
          'user_address': addressController.text,
          'user_phone': phoneController.text,
          'coffee_name': coffee['coffee_name'],
          'price': price,
          'quantity': quantity,
          'total': total,
          'status': 'Confirmed',
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        showConfirmOrder();
      } else {
        Text('issue');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Text('Network error');
    }
  }

  void showConfirmOrder() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title:  Text(
            'Order Confirmed ☕',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: Text('Your coffee order has been placed successfully!'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final coffee = widget.coffee;

    int price = coffee['price'];

    int total = price * quantity;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor:  Color(0xff3b2920),
        title:  Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your coffee',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xff3b2920),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Row(
                children: [
                  Image.network(
                    coffee['image_url'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          coffee['coffee_name'],

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3b2920),
                          ),
                        ),
                        SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 4),

                            Text(
                              '${coffee['ratings']}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Text(
                          '₹$price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffa66b43),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Container(
                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),

                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height:20),

            Spacer(),

            Container(
              padding: EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Subtotal'), Text('₹$total')],
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Delivery'), Text('FREE')],
                  ),

                  Divider(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        '₹$total',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8d5538),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 5),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: sendpostrequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff8d5538),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    SizedBox(width: 10),
                    Text(
                      'Confirm Order',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
