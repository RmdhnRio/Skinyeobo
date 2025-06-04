import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ProductDetail.dart';
import 'theme/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const Cart());
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: AppColorScheme.lightColorScheme,
        useMaterial3: true,
        fontFamily: 'CabinetGrotesk',
      ),
      home: const MyCartPage(),
    );
  }
}

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Si Peeling Serum',
      'volume': '30 ml',
      'price': 18.00,
      'oldPrice': 24.00,
      'qty': 1,
    },
    {
      'name': 'Met Bobo Cream',
      'volume': '80 ml',
      'price': 15.00,
      'oldPrice': 16.50,
      'qty': 1,
    },
    {
      'name': 'Freshly Face Wash',
      'volume': '120 ml',
      'price': 10.00,
      'oldPrice': 15.00,
      'qty': 2,
    },
  ];

  void increaseQuantity(int index) {
    setState(() {
      setState(() {
        items[index]['qty']++;
        updateTotalPrice();
      });
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (items[index]['qty'] > 1) {
        items[index]['qty']--;
        updateTotalPrice();
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  double subTotal = 0.0;
  double shippingCost = 33.0;
  double total = 0.0;

  void updateTotalPrice() {
    setState(() {
      subTotal = 0.0;
      for (var item in items) {
        subTotal += (item['price'] * item['qty']);
      }
      total = subTotal + shippingCost;
    });
  }

  @override
  void initState() {
    super.initState();
    updateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Column(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: ColorPalette.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Order Details',
                        style:
                            TextStyle(color: ColorPalette.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  // Item List
                  Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Stack(
                        children: [
                          SizedBox(
                              height: 240,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return _buildCartCard(index);
                                    }),
                              )),
                          Positioned(
                            bottom: -5,
                            left: 0,
                            right: 0,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.white.withOpacity(0.0),
                                  ColorPalette.white,
                                ],
                              )),
                            ),
                          ),
                        ],
                      )),

                  const SizedBox(
                    height: 12,
                  ),

                  // Location
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      elevation: 0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              child: const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Delivery Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPalette.secondary),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Material(
                                  color: ColorPalette.backgroundGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 8, 8, 8),
                                        child: Image.asset(
                                            'assets/images/location_pin.png',
                                            fit: BoxFit.contain),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Jl. Westview, New Jersey'),
                                      Text('(212) 456-7890')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.chevron_right,
                                        color: ColorPalette.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Delivery Method
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      elevation: 0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              child: const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Delivery Method',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPalette.secondary),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Material(
                                  color: ColorPalette.backgroundGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 8),
                                        child: Image.asset(
                                            'assets/images/drone.png',
                                            fit: BoxFit.contain),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Drone Service Delivery'),
                                      Text('\$20 - 40 (Fare)')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.chevron_right,
                                        color: ColorPalette.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Payment Method
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      elevation: 0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              child: const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Payment Method',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPalette.secondary),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Material(
                                  color: ColorPalette.backgroundGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 8),
                                        child: Image.asset(
                                            'assets/images/coin.png',
                                            fit: BoxFit.contain),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Paylater',
                                      ),
                                      Text('Pay at the end of month'),
                                      Text('Credit : \$200')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.chevron_right,
                                        color: ColorPalette.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),

            // Cart Summary
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.secondary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtotal Row
                        _buildSummaryRow(
                            'Subtotal', '\$${subTotal.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),

                        // Shipping Cost Row
                        _buildSummaryRow('Shipping Cost',
                            '\$${shippingCost.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),

                        // Total Row
                        _buildSummaryRow(
                          'Total',
                          '\$${total.toStringAsFixed(2)}',
                          isTotal: true,
                        ),

                        // Voucher Text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Got any voucher?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),

                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle checkout
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Checkout (\$${total.toStringAsFixed(2)})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Update the _buildSummaryRow to use the calculated values
  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? ColorPalette.black : Colors.grey[600],
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: isTotal ? ColorPalette.black : Colors.grey[600],
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildCartCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorPalette.pink,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Image.asset('assets/images/product_${index + 1}.png',
                        fit: BoxFit.contain),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    items[index]['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    items[index]['volume'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: ColorPalette.orange, width: 1)),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => decrementQuantity(index),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.remove,
                                    size: 14, color: ColorPalette.orange),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          items[index]['qty'].toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: ColorPalette.orange, width: 1)),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => increaseQuantity(index),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.add,
                                    size: 14, color: ColorPalette.orange),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 22),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${items[index]['oldPrice']}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${items[index]['price']}',
                      style: const TextStyle(
                        color: ColorPalette.salmon,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.grey[300],
                        child: InkWell(
                          onTap: () => {}, //removeItem(index),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.delete,
                                size: 16, color: ColorPalette.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
