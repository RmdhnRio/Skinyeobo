import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ProductDetail.dart';
import 'theme/colors.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const VoucherPage());
  
}

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  String selectedFilter = 'All';
  bool _isLoading = true;
  final List<Map<String, String>> voucherData = [
    {
      'imageUrl': 'assets/images/new_member_voucher.png',
      'tcDescription':
          'Valid for new members only. Cannot be combined with other promotions.',
    },
    {
      'imageUrl': 'assets/images/ramadhan_voucher.png',
      'tcDescription': 'Special Ramadhan promotion. Valid for all services.',
    },
    {
      'imageUrl': 'assets/images/payday_voucher.png',
      'tcDescription': 'Special payday promotion. Valid for all services.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Column(
          children: [
            //Header Section
            Padding(
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
                      'My Voucher',
                      style: TextStyle(color: ColorPalette.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            // Filter buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildFilterButton('All'),
                  const SizedBox(width: 8),
                  _buildFilterButton('Face'),
                  const SizedBox(width: 8),
                  _buildFilterButton('Hair'),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: _isLoading
                    ? List.generate(
                        3,
                        (index) => const VoucherCardShimmer(),
                      )
                    : List.generate(
                        voucherData.length,
                        (index) => VoucherCard(
                          imageUrl: voucherData[index]['imageUrl']!,
                          tcDescription: voucherData[index]['tcDescription']!,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    bool isSelected = selectedFilter == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ColorPalette.orange : ColorPalette.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? ColorPalette.white : ColorPalette.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class VoucherCardShimmer extends StatelessWidget {
  const VoucherCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 160,
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class VoucherCard extends StatefulWidget {
  final String imageUrl;
  final String tcDescription;

  const VoucherCard({
    Key? key,
    required this.imageUrl,
    required this.tcDescription,
  }) : super(key: key);

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  bool isExpanded = false;
  bool _isImageLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                //Shimmer effect while image is loading
                if (_isImageLoading) const VoucherCardShimmer(),

                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (frame != null) {
                          Future.microtask(() {
                            if (mounted && _isImageLoading) {
                              setState(() {
                                _isImageLoading = false;
                              });
                            }
                          });
                        }
                        return child;
                      },
                    ))
              ],
            ),
          ),
        ),

        // Expandable T&C Section
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Terms & Conditions:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(widget.tcDescription),
                ],
              )),
        ),
      ],
    );
  }
}
