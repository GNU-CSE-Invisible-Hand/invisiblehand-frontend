import 'package:flutter/material.dart';
import 'stock_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // BottomNavigationBar에서 선택된 탭 인덱스
  int _selectedIndex = 1;

  // 관심 목록에 보여줄 예시 종목 데이터
  final List<Map<String, dynamic>> _stockItems = [
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
    {
      'name': '테슬라',
      'change': 0.1,
      'price': '344,283원',
      'iconLabel': '',
    },
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
    {
      'name': 'PLTD',
      'change': 0.8,
      'price': '25,000원',
      'iconLabel': '',
    },
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
    {
      'name': '엄준식',
      'change': -0.02,
      'price': '440,678원',
      'iconLabel': 'x2', // 레버리지 같은 표시
    },
  ];

  // BottomNavigationBar 아이템
  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '홈',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star_border),
      label: '관심',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: '발견',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.feed),
      label: '피드',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 AppBar
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '코스닥 718.62',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Text(
              '-0.9%',
              style: TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 검색 기능
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // 메뉴 기능
            },
          ),
        ],
        elevation: 0,
      ),

      // 중간 영역: 탭(Chip) + 종목 리스트
      body: Column(
        children: [
          // 가로 스크롤 Chip 목록
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildCategoryChip('최근 본', isSelected: true),
                _buildCategoryChip('주식'),
                _buildCategoryChip('엔비디아'),
                _buildCategoryChip('+ 추가'),
                _buildCategoryChip('편집'),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),

          // 종목 리스트
          Expanded(
            child: ListView.builder(
              itemCount: _stockItems.length,
              itemBuilder: (context, index) {
                final item = _stockItems[index];
                final change = item['change'] as double;
                final isPositive = change >= 0;

                return ListTile(
                  leading: _buildStockIcon(item['iconLabel']),
                  title: Text(item['name']),
                  subtitle: Text(item['price']),
                  trailing: Text(
                    '${isPositive ? '+' : ''}${(change * 100).toStringAsFixed(1)}%',
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

      // 하단 탭
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          // 실제 앱이라면 index별 화면 전환 로직 추가
        },
      ),
    );
  }

  // 카테고리 Chip 빌더
  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          // 실제 앱에서는 해당 탭으로 이동하거나, 목록 갱신 등을 수행
        },
      ),
    );
  }

  // 종목 리스트 아이콘(예: 레버리지 x2 등)
  Widget _buildStockIcon(String iconLabel) {
    if (iconLabel.isEmpty) {
      return const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.show_chart, color: Colors.white),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Text(
          iconLabel,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
