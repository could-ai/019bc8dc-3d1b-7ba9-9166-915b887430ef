import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/company.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalInvestment = MockData.getTotalInvestment();
    final activeCount = MockData.getActiveCount();
    final totalCount = MockData.companies.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VC 管理仪表盘'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '概览',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    '总投资额',
                    '¥${totalInvestment.toStringAsFixed(1)}M',
                    Icons.monetization_on,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    '被投企业',
                    '$totalCount 家',
                    Icons.business,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    '运营中',
                    '$activeCount 家',
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    '已退出',
                    '${totalCount - activeCount} 家',
                    Icons.exit_to_app,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '近期动态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildRecentActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 28),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList() {
    // Mock recent activities
    final activities = [
      {'title': 'Future AI 完成 A 轮融资', 'date': '2023-10-01'},
      {'title': 'Green Energy 发布新产品', 'date': '2023-09-28'},
      {'title': 'MediTech Pro 季度财报更新', 'date': '2023-09-15'},
    ];

    return Column(
      children: activities.map((activity) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.notifications, color: Colors.white, size: 20),
            ),
            title: Text(activity['title']!),
            subtitle: Text(activity['date']!),
          ),
        );
      }).toList(),
    );
  }
}
