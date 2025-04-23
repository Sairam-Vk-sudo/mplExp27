import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Demo',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> items = const [
    "Milk",
    "Cheese",
    "Paneer",
    "Curd",
    "Butter",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Demo"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildWelcomeRow(),
              const SizedBox(height: 20),
              _buildStackExample(),
              const SizedBox(height: 20),
              _buildListViewExample(),
              const SizedBox(height: 20),
              _buildButtonExample(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.lightBlue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Welcome, User", style: TextStyle(fontSize: 16)),
          Text("Logout", style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildStackExample() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.lightGreen.shade100,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black.withOpacity(0.6),
          child: const Text(
            "Stacked Text",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildListViewExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "List of Items:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.grey.shade200,
              child: Text(items[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildButtonExample(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Button Pressed")),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        color: Colors.blue,
        child: const Text(
          "Press Me",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
