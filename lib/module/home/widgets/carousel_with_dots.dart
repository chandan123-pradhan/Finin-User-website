import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithDots extends StatefulWidget {
  @override
  _CarouselWithDotsState createState() => _CarouselWithDotsState();
}

class _CarouselWithDotsState extends State<CarouselWithDots> {
  int _currentIndex = 0;

  final List<String> _imageUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaviuJ9awxSZre2o6O2ucAU9Xz02phpPAHXA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVGkTO6gnYfy13Uwm2bHNy8UZhs2q20kfFVg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs1xk6Tin7lBk3Md6-YHYvAHdMQKWzACrRQg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaviuJ9awxSZre2o6O2ucAU9Xz02phpPAHXA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVGkTO6gnYfy13Uwm2bHNy8UZhs2q20kfFVg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs1xk6Tin7lBk3Md6-YHYvAHdMQKWzACrRQg&s",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          
          items: _imageUrls.map((imageUrl) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl,
                  fit: BoxFit.cover, width: double.infinity),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            viewportFraction: 0.9,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imageUrls.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = entry.key),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
