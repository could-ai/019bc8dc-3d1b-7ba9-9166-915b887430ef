import 'package:flutter/material.dart';
import '../models/company.dart';

class CompanyDetailScreen extends StatelessWidget {
  final Company company;

  const CompanyDetailScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(),
            _buildInfoSection(),
            const Divider(),
            _buildFinancialSection(),
            const Divider(),
            _buildDescriptionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.indigo.shade50,
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.indigo,
            child: Text(
              company.name.substring(0, 1),
              style: const TextStyle(fontSize: 32, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            company.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(company.status),
            backgroundColor: company.status == 'Active' ? Colors.green.shade100 : Colors.grey.shade200,
            labelStyle: TextStyle(
              color: company.status == 'Active' ? Colors.green.shade800 : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基本信息', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow('行业', company.sector),
          _buildInfoRow('轮次', company.stage),
          _buildInfoRow('创始人', company.founder),
          _buildInfoRow('投资日期', company.investmentDate.toString().split(' ')[0]),
        ],
      ),
    );
  }

  Widget _buildFinancialSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('财务数据', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow('投资金额', '¥${company.investmentAmount}M'),
          _buildInfoRow('当前估值', '¥${company.valuation}M'),
          _buildInfoRow('回报倍数', '${(company.valuation / company.investmentAmount).toStringAsFixed(1)}x'),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('公司简介', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            company.description,
            style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        ],
      ),
    );
  }
}
