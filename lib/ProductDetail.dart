import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:skinyeobo/cart.dart';
import 'package:skinyeobo/theme/colors.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:skinyeobo/utils/page_transitions.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final double price;
  final double discountedPrice;
  final int productIndex;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.price,
    required this.discountedPrice,
    required this.productIndex,
  });

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
        backgroundColor: ColorPalette.white,
        body: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Hero(
                              tag: 'product_$productIndex',
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 36),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                decoration: const BoxDecoration(
                                    color: ColorPalette.pink,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: Image.asset(
                                  'assets/images/product_${productIndex}_xl.png',
                                  fit: BoxFit.contain,
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: ColorPalette.pink,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: IconButton(
                                      icon: const Icon(Icons.favorite_border,
                                          color: ColorPalette.red),
                                      onPressed: () {}),
                                ),
                              ],
                            ),
                            const Text(
                              'By SkinYeobo',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Size: 30 ml / 1.01 fl. oz.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              '"Serum yang si paling serum"',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 70,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: const [
                                  Text(
                                    'Stronger % Dose peeling option for you who are used to AHA BHA PHA actives, infused with Mugwort & Calendula to level up your skincare.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Reviews and stuff
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 80),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildReviewCard(
                                    'assets/images/reviewer_1.png',
                                    'Sarah Anne | 15/01/24',
                                    'I think this was the best serum that i purchase here',
                                    5,
                                  ),
                                  _buildReviewCard(
                                    'assets/images/reviewer_2.png',
                                    'Jane Doe | 04/11/24',
                                    'I did not know until now this serum could be this soothing for my skin',
                                    4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: ColorPalette.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // Cart button with badge
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: ColorPalette.black,
                          ),
                          onPressed: () {
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Purchase section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: ColorPalette.orange),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      Container(
                        child: Text(
                          '\$$price',
                          style: AppTextStyles.productDetailDesc.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: ColorPalette.black,
                              fontSize: 13),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          '\$$discountedPrice',
                          style: AppTextStyles.productDetailName.copyWith(
                              color: ColorPalette.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 28),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.cream,
                    ),
                    child: Text('+ Add to cart',
                        style: TextStyle(
                            color: ColorPalette.black,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  Widget _buildReviewCard(
    String imagePath,
    String reviewer,
    String review,
    int rating,
  ) {
    return Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewer,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
