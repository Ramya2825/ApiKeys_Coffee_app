import 'package:coffee_app/bookings_card.dart';
import 'package:flutter/material.dart';

class CoffeeDetailPage extends StatefulWidget {
  final Map<String, dynamic> coffee;
  final List<Map<String, dynamic>> cartItems;

  const CoffeeDetailPage({
    super.key,
    required this.coffee,
    required this.cartItems,
  });

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {

  int quantity = 1;
  String size = 'M';
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final coffee = widget.coffee;
    final int price = coffee['price'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        title: Text(
          'Coffee Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              width: double.infinity,

              child: Image.network(coffee['image_url'], fit: BoxFit.cover),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          coffee['coffee_name'],
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E2918),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'ID: ${coffee['id']}',
                          style: TextStyle(
                            color: Color(0xFF6F3E25),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 26),

                      SizedBox(width: 6),

                      Text(
                        '${coffee['ratings']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 8),

                      Text(
                        'Customer Rating',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),

                  SizedBox(height: 22),

                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_cafe, color: Colors.white, size: 35),

                        SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Your Coffee',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Text(
                          '₹$price',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  Text(
                    'Choose your size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3b2920),
                    ),
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      coffeeSize('S'),
                      coffeeSize('M'),
                      coffeeSize('L'),
                    ],
                  ),

                  SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E2918),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            quantityButton(Icons.remove, () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            }),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            quantityButton(Icons.add, () {
                              setState(() {
                                quantity++;
                              });
                            }),
                          ],
                        ),
                      ),

                      Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(color: Colors.black54),
                          ),

                          Text(
                            '₹${price * quantity}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 25),

                  Text(
                    'About This Coffee',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E2918),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    coffee['description'],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 25),

                  Row(
                    children: [
                      _buildFeature(Icons.coffee, 'Freshly\nBrewed'),
                      SizedBox(width: 10),
                      _buildFeature(Icons.spa, 'Rich\nFlavour'),
                      SizedBox(width: 10),
                      _buildFeature(Icons.favorite, 'Made with\nLove'),
                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 58,
                          child: OutlinedButton.icon(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.brown,
                            ),

                            label: Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),

                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.brown, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Add to Cart.☕️')),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 58,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),

                            label: Text(
                              'Buy Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CartPage(coffee: coffee),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coffeeSize(String sizeOption) {
    final bool isSelected = size == sizeOption;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              size = sizeOption;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.brown : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.brown),
            ),
            child: Text(
              sizeOption,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Color(0xFF4E2918)),
      constraints: BoxConstraints(minWidth: 36, minHeight: 36),
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 105,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF0E2D5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFF6F3E25), size: 28),

            SizedBox(height: 8),

            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
