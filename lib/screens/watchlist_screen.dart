import 'package:flutter/material.dart';
import 'stock_detail_screen.dart'; // 필요에 따라 따로 import

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stockItems = [
      {
        'name': '엄준식',
        'change': -0.02,
        'price': '440,678원',
        'iconLabel': 'x2',
      },
      {
        'name': '테슬라',
        'change': 0.1,
        'price': '344,283원',
        'iconLabel': '',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('코스닥 718.62', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            const Text('-0.9%', style: TextStyle(color: Colors.redAccent)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildCategoryChip('최근 본', isSelected: true),
                _buildCategoryChip('주식'),
                _buildCategoryChip('엔비디아'),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: stockItems.length,
              itemBuilder: (context, index) {
                final item = stockItems[index];
                final isPositive = (item['change'] as double) >= 0;
                return ListTile(
                  leading: _buildStockIcon(item['iconLabel']),
                  title: Text(item['name']),
                  subtitle: Text(item['price']),
                  trailing: Text(
                    '${isPositive ? '+' : ''}${(item['change'] * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: isPositive ? Colors.redAccent : Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetailScreen(
                          stockName: item['name'],
                          stockPrice: item['price'],
                          change: item['change'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {},
      ),
    );
  }

  Widget _buildStockIcon(String iconLabel) {
    if (iconLabel.isEmpty) {
      return const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.show_chart, color: Colors.white),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Text(iconLabel, style: const TextStyle(color: Colors.white)),
      );
    }
  }
}
