import 'package:flutter/material.dart';

class Order {
  final String id, variant, imageUrl, status;
  final DateTime date;
  final int price, quantity;
  Order({
    required this.id,
    required this.variant,
    required this.imageUrl,
    required this.status,
    required this.date,
    required this.price,
    required this.quantity,
  });
}

class OrdersPageuiiui extends StatefulWidget {
  const OrdersPageuiiui({super.key});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPageuiiui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        bottom: TabBar(
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'New'),
            Tab(text: 'Accepted'),
            Tab(text: 'Declined'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Orders...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          TabBarView(
            children: ['All', 'New', 'Accepted', 'Declined'].map((tab) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => buildCard(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget buildCard() {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
            "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=400&q=60",
            width: 80,
            height: 80,
            fit: BoxFit.cover),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('#sdfhuhuhuhf 7978787df',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('₹4.8855', style: const TextStyle(fontSize: 16)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text('Variant: jghhk', style: const TextStyle(color: Colors.grey)),
          Text('Quantity 4545 Item'),
          const SizedBox(height: 4),
          Text("${DateTime.now()}", style: const TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}
