import '../models/company.dart';

class MockData {
  static List<Company> companies = [
    Company(
      id: '1',
      name: 'Future AI',
      sector: '人工智能',
      stage: 'Series A',
      investmentAmount: 5.0,
      valuation: 25.0,
      founder: '张三',
      investmentDate: DateTime(2022, 5, 15),
      description: '专注于生成式AI的企业解决方案提供商。',
      status: 'Active',
    ),
    Company(
      id: '2',
      name: 'Green Energy',
      sector: '新能源',
      stage: 'Seed',
      investmentAmount: 1.2,
      valuation: 8.0,
      founder: '李四',
      investmentDate: DateTime(2023, 1, 10),
      description: '下一代固态电池研发。',
      status: 'Active',
    ),
    Company(
      id: '3',
      name: 'MediTech Pro',
      sector: '医疗健康',
      stage: 'Series B',
      investmentAmount: 12.0,
      valuation: 60.0,
      founder: '王五',
      investmentDate: DateTime(2021, 8, 20),
      description: 'AI辅助诊断系统。',
      status: 'Active',
    ),
    Company(
      id: '4',
      name: 'Cloud Secure',
      sector: '网络安全',
      stage: 'Series A',
      investmentAmount: 3.5,
      valuation: 18.0,
      founder: '赵六',
      investmentDate: DateTime(2022, 11, 5),
      description: '云原生安全防护平台。',
      status: 'Active',
    ),
    Company(
      id: '5',
      name: 'Quick Logistics',
      sector: '物流',
      stage: 'Exit',
      investmentAmount: 2.0,
      valuation: 0.0, // Exited
      founder: '钱七',
      investmentDate: DateTime(2020, 3, 12),
      description: '同城极速配送网络。',
      status: 'Exited',
    ),
  ];

  static double getTotalInvestment() {
    return companies.fold(0, (sum, item) => sum + item.investmentAmount);
  }

  static int getActiveCount() {
    return companies.where((c) => c.status == 'Active').length;
  }
}
