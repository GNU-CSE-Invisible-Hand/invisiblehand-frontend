import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StockDetailScreen extends StatefulWidget {
  final String stockName;  // 종목명
  final String stockPrice; // 종목 가격
  final double change;     // 변동률

  const StockDetailScreen({
    Key? key,
    required this.stockName,
    required this.stockPrice,
    required this.change,
  }) : super(key: key);

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  // WebViewController를 저장할 변수 (필요시)
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        // 예: 테슬라(NASDAQ:TSLA) 차트를 TradingView 웹으로 임베드한 예시
        // 실제 종목에 맞춰 URL을 바꾸거나, 위젯 스크립트를 사용해보세요.
          'https://www.tradingview.com/chart/?symbol=NASDAQ:TSLA'
      ));
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.change >= 0;
    final changeColor = isPositive ? Colors.redAccent : Colors.blueAccent;
    final changeText = '${isPositive ? '+' : ''}${(widget.change * 100).toStringAsFixed(2)}%';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockName),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // 관심 종목 추가 로직
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 상단 종목 정보
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 종목명 + 가격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stockName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.stockPrice,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        changeText,
                        style: TextStyle(
                          fontSize: 16,
                          color: changeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // 통화 단위나 아이콘
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // 원/달러 등 통화 변환 로직
                    },
                    child: const Text('원'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),

          // 차트 / WebView 영역
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),

          // 하단 메뉴 (차트 / 정보 / 뉴스 등 탭 전환 가능)
          // Container(
          //   height: 50,
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       _buildBottomMenuItem('차트', Icons.show_chart),
          //       _buildBottomMenuItem('내 주식', Icons.pie_chart_outline),
          //       _buildBottomMenuItem('종목정보', Icons.info_outline),
          //       _buildBottomMenuItem('커뮤니티', Icons.chat_bubble_outline),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(String label, IconData icon) {
    return InkWell(
      onTap: () {
        // 예: 탭 전환 또는 다른 화면으로 이동
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
