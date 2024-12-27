import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'offerctrlr.dart';


class OffersView extends StatelessWidget {
  final OffersController offersController = Get.put(OffersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offers Carousel')),
      body: Obx(() {
        if (offersController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (offersController.offers.isEmpty) {
          return const Center(child: Text("No offers available"));
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 150.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: offersController.offers.map((offer) {
            return Builder(
              builder: (BuildContext context) {
                // Use placeholder if image is null
                final imageUrl = offer['image'] ?? 'https://via.placeholder.com/300x150';

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      }),
    );
  }
}
