import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Display App',
      home: ItemDisplayScreen(),
    );
  }
}

class ItemObject {
  final String name;
  final String imagePath;

  ItemObject({required this.name, required this.imagePath});
}

class ItemDisplayScreen extends StatefulWidget {
  @override
  _ItemDisplayScreenState createState() => _ItemDisplayScreenState();
}

class _ItemDisplayScreenState extends State<ItemDisplayScreen> {
  final TextEditingController itemController = TextEditingController();
  late List<ItemObject> items;

  @override
  void initState() {
    super.initState();

    
    items = [
      ItemObject(name: "Apple", imagePath: "assets/apple_image.jpg"),
      ItemObject(name: "Orange", imagePath: "assets/orange_image.jpg"),
      ItemObject(name: "Rambutan", imagePath: "assets/rambutan_image.jpg"),
      ItemObject(name: "Iphone", imagePath: "assets/vpavic_210916_4760_0240.jpg"),
      // Add more items as needed
    ];
  }

  String getImagePath(String itemName) {
    // Get the image path for the given item
    return items.firstWhere((item) => item.name.toLowerCase() == itemName.toLowerCase(),
        orElse: () => ItemObject(name: "", imagePath: "")).imagePath;
  }

  void displayChoice() {
    // Display the image for the entered choice
    String itemName = itemController.text;
    String imagePath = getImagePath(itemName);

    if (imagePath.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.asset(imagePath),
          );
        },
      );
    } else {
      // Handle case when item is not found
      // You can show an error message or take appropriate action
      print("Item not found!");
    }
  }

  void luckyChoice() {
    // Display a randomly selected image from the list
    if (items.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(items.length);
      String randomImagePath = items[randomIndex].imagePath;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.asset(randomImagePath),
          );
        },
      );
    } else {
      // Handle case when the list is empty
      // You can show an error message or take appropriate action
      print("No items available!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Display App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: itemController,
              decoration: InputDecoration(labelText: 'Enter Item'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: displayChoice,
              child: Text('Display Choice'),
              Color:Color.red,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: luckyChoice,
              child: Text("I'm Feeling Lucky"),
            ),
          ],
        ),
      ),
    );
  }
}
