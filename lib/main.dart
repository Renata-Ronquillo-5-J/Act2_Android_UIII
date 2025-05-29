import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Stack List Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StackListAnimationScreen(),
    );
  }
}

class StackListAnimationScreen extends StatefulWidget {
  const StackListAnimationScreen({super.key});

  @override
  State<StackListAnimationScreen> createState() => _StackListAnimationScreenState();
}

class _StackListAnimationScreenState extends State<StackListAnimationScreen> {
  final ScrollController _scrollController = ScrollController();
  List<FoodItem> foodItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize your list of items
    foodItems = [
      FoodItem(name: 'Bolso', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno1.jpg'), // Placeholder for Image 1 (Chicken)
      FoodItem(name: 'Labial', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno2.jpg'),   // Placeholder for Image 1 (Burger)
      FoodItem(name: 'Zapatos', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno3.jpg?text=Noodles'), // Placeholder for Image 1 (Noodles)
      FoodItem(name: 'Jarra', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno10.jpg'),// Placeholder for Image 1 (Lemon)
      FoodItem(name: 'Blusa', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno11.jpg'),       // Placeholder for Image 2 (Rum)
      FoodItem(name: 'Lampara', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno5.jpg'),   // Placeholder for Image 2 (Cheese)
      FoodItem(name: 'Reloj', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno6.jpg'),// Placeholder for Image 2 (CocaCola)
      FoodItem(name: 'Camara', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno8.jpg'),// Placeholder for Image 2 (Ice Cream)
      FoodItem(name: 'Repizza', imageUrl: 'https://raw.githubusercontent.com/Renata-Ronquillo-5-J/Imagenes/refs/heads/master/Uno9.jpg'),         // Placeholder for Image 2 (Pizza)
      // Add more items if needed
    ];

    _scrollController.addListener(() {
      setState(() {
        // This setState is to rebuild the list items when scroll happens
        // to apply the transformations based on scroll position.
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miniso Coupons & Discover', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top section (Discover, Most Favorite, Newest, etc.)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Descubrir ofertas',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Ver todo >', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120, // Height for the horizontal scroll cards
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildDiscoverCard('Favoritos', Colors.orange),
                      _buildDiscoverCard('Nuevos', Colors.blue),
                      _buildDiscoverCard('Descuentos de verano', Colors.purple),
                      _buildDiscoverCard('Miniso Exclusivos', Colors.pink),
                      // Añade un espacio o más tarjetas para forzar el desplazamiento
                      const SizedBox(width: 16), // Espacio adicional para permitir el desplazamiento
                      _buildDiscoverCard('Ofertas del día', Colors.red), // Un elemento extra
                      _buildDiscoverCard('Liquidación', Colors.teal), // Otro elemento extra
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Mis productos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Stack List Animation Section
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final itemHeight = 150.0; // Define height of each list item
                final itemPosition = index * itemHeight;
                final scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;

                // Calculate the difference from the current scroll position
                final centerOffset = scrollOffset + MediaQuery.of(context).size.height / 2;
                final distanceToCenter = (itemPosition + itemHeight / 2) - centerOffset;

                // Apply a scaling and opacity based on distance from center
                // You can experiment with different calculations for desired effect
                final maxScale = 1.0;
                final minScale = 0.8;
                final maxOpacity = 1.0;
                final minOpacity = 0.5;

                final normalizedDistance = (distanceToCenter.abs() / (MediaQuery.of(context).size.height / 2)).clamp(0.0, 1.0);
                final scale = maxScale - (maxScale - minScale) * normalizedDistance;
                final opacity = maxOpacity - (maxOpacity - minOpacity) * normalizedDistance;

                // For a "stack" effect, you might want to translate items slightly
                // For example, items further away move slightly up/down
                final translateX = 0.0;
                final translateY = distanceToCenter * 0.1; // Adjust multiplier for effect

                return Align( // Use Align to ensure transformations don't affect layout of others
                  heightFactor: 0.8, // Make items slightly overlap
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: Transform.translate(
                        offset: Offset(translateX, translateY),
                        child: _buildCouponCard(foodItems[index], itemHeight),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverCard(String title, Color color) {
    return Card(
      color: color,
      margin: const EdgeInsets.only(right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 150, // Mantén el ancho fijo para cada tarjeta
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '15 items',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.favorite_border, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(FoodItem item, double height) {
    Color cardColor;
    switch (item.name) {
      case 'Bolso':
      case 'Blusa':
      case 'Reloj':
        cardColor = Colors.pinkAccent.shade100;
        break;
      case 'Camara':
      case 'Labial':
      case 'Jarra':
        cardColor = Colors.lightBlue.shade300;
        break;
      case 'Zapatos':
      case 'Lampara':
        cardColor = Colors.lightGreen.shade300;
        break;
      case 'Repizza':
        cardColor = Colors.yellow.shade300;
        break;
      default:
        cardColor = Colors.grey.shade300;
    }

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                item.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItem {
  final String name;
  final String imageUrl;

  FoodItem({required this.name, required this.imageUrl});
}