import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:skinyeobo/utils/page_transitions.dart';
import 'package:skinyeobo/voucher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ProductDetail.dart';
import 'cart.dart';
import 'theme/colors.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        colorScheme: AppColorScheme.lightColorScheme,
        useMaterial3: true,
        fontFamily: 'CabinetGrotesk',
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> categories = [
    'All',
    'Face',
    'Hair',
    'Body',
    'Vitamins',
    'Private Area',
    'Other'
  ];
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  String? errorMessage;
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      // ambil data 'products' dari firestore
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      setState(() {
        products = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load products. Please try again.';
        isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              // Top Header with Profile and Cart
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Gretings(), style: AppTextStyles.greetings),
                              Text(
                                'Safitri',
                                style: AppTextStyles.textSmall
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: ColorPalette.black,
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) => Cart()),
                          // );

                          context.pushWithTransition(
                            const MyCartPage(),
                            type: TransitionType.slide,
                          );
                        },
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: ColorPalette.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                                color: ColorPalette.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Search TextField Column - Takes most of the space
                  Expanded(
                    flex: 4, // Takes 80% of the width
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: ColorPalette.black),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search something',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Filter Button Column
                  const SizedBox(width: 12), // Space between search and filter
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColorScheme.lightColorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.only(right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categories[index],
                              style: TextStyle(
                                color: selectedCategoryIndex == index
                                    ? ColorPalette.orange
                                    : Colors.grey,
                                fontWeight: selectedCategoryIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                margin: const EdgeInsets.only(top: 4),
                                width: selectedCategoryIndex == index ? 20 : 0,
                                height: 2,
                                color: ColorPalette.orange),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Product Grid
            Expanded(
              child: RefreshIndicator(
                onRefresh: fetchProducts,
                child: isLoading
                    ? _buildShimmerLoading()
                    : errorMessage != null
                        ? _buildErrorWidget()
                        : errorMessage != null
                            ? _buildErrorWidget()
                            : products.isEmpty
                                ? Center(
                                    child: Text(
                                      'No products found',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return _buildProductCard(index);
                                    },
                                  ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: AppColorScheme.lightColorScheme.primary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                      icon: const Icon(Icons.card_giftcard),
                      onPressed: () {
                        context.pushWithTransition(
                          const VoucherPage(),
                          type: TransitionType.slide,
                        );
                      }),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chip(
            backgroundColor: Colors.red[100],
            label: Text(
              errorMessage ?? 'An error occurred',
              style: TextStyle(color: Colors.red[900]),
            ),
            avatar: Icon(Icons.error_outline, color: Colors.red[900]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: fetchProducts,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final product = products[index];
    final double discountedPrice =
        product['price'].toDouble() - product['disc_amount'].toDouble();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productName: product['name'],
              price: product['price'].toDouble(),
              discountedPrice: discountedPrice,
              productIndex: product['sysNo'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    decoration: BoxDecoration(
                      color: ColorPalette.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Hero(
                    tag: 'product_${product['sysNo']}',
                    child: Container(
                      decoration: BoxDecoration(
                        //color: ColorPalette.pink,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                            'assets/images/product_${product['sysNo']}.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 8,
                      top: 20,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ColorPalette.white50,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(32),
                                bottomLeft: Radius.circular((32)))),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: ColorPalette.salmon,
                          ),
                          onPressed: () {},
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                product['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                '${product['size']} ${product['uom']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '\$${discountedPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColorScheme.lightColorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '\$${product['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${product['rating']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String Gretings() {
  final currentTime = DateTime.now();
  final hour = currentTime.hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}
