import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1_mevivu/controller/cart_controller.dart';
import 'package:test1_mevivu/controller/product_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "GemStore",
          style: GoogleFonts.ptSans(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 15,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(controller.categories.length, (index) {
                  return InkWell(
                    onTap: () => controller.changeCate(index),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              controller.selectCateIndex.value == index
                                  ? Colors.black
                                  : Colors.grey[300],
                          child: Icon(
                            controller.cateIcon[index],
                            color: controller.selectCateIndex.value == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          controller.categories[index],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/images/A.png"),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/images/B.png"),
                )
              ],
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Feature Products",
                  style: GoogleFonts.ptSans(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.isLoading.value
                  ? Center(child: const CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: CarouselSlider.builder(
                                    itemCount: product.images.length,
                                    itemBuilder:
                                        (context, imageIndex, realIndex) {
                                      return Image.network(
                                        product.images[imageIndex],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                    options: CarouselOptions(
                                      // autoPlay: true,
                                      viewportFraction: 1.0,
                                      aspectRatio: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: GoogleFonts.ptSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price}',
                                          style: GoogleFonts.ptSans(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final box = GetStorage();
                                            final token = box.read('token');

                                            if (token != null &&
                                                token.isNotEmpty) {
                                              if (!cartController
                                                  .isLoading.value) {
                                                cartController
                                                    .addToCart(product);
                                              }
                                            } else {
                                              Get.snackbar(
                                                "Authentication Required",
                                                "Please log in to add items to your cart.",
                                                backgroundColor: Colors.red,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                colorText: Colors.white
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xff33302E)),
                                          child: Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
