import 'dart:convert';

import 'package:coffee_app/coffee_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Apiservice extends StatefulWidget {
  const Apiservice({super.key});

  @override
  State<Apiservice> createState() => _ApiserviceState();
}

class _ApiserviceState extends State<Apiservice> {
  List<Map<String, dynamic>> data = [];
  final TextEditingController searchController = TextEditingController();

  void fetchUsers() async {
    print('fetchUsers called');

    const url = 'https://6adb0cc17512f497b300640f.mockapi.io/api/v1/coffees';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body) as List<dynamic>;

      setState(() {
        data = List<Map<String, dynamic>>.from(json);
      });

      print('fetchUsers completed');
    } else {
      print('Failed to fetch coffees: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Oh Coffee Cafe')),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,

        actions: [Icon(Icons.add_shopping_cart_outlined)],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(20, 10, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find the best',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Coffee to your taste.☕️',
                  style: TextStyle(
                    color: Color.fromARGB(255, 152, 116, 103),
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find your coffee...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 94, 69, 41),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 25),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final singleCoffee = data[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoffeeDetailPage(
                          coffee: singleCoffee,
                          cartItems: [],
                        ),
                      ),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.brown.shade200),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          singleCoffee['image_url'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        SizedBox(height: 10),

                        Text(
                          singleCoffee['coffee_name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade900,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Price: ₹${singleCoffee['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 18),

                            SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                '${singleCoffee['ratings']} Ratings',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Expanded(
                          child: Text(
                            singleCoffee['description'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
