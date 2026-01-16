import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/company.dart';
import 'company_detail_screen.dart';
import 'add_company_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  List<Company> _filteredCompanies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _filteredCompanies = List.from(MockData.companies);
    });
  }

  void _filterCompanies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCompanies = List.from(MockData.companies);
      } else {
        _filteredCompanies = MockData.companies
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()) ||
                          c.sector.contains(query))
            .toList();
      }
    });
  }

  Future<void> _navigateToAddCompany() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCompanyScreen()),
    );

    if (result == true) {
      _filterCompanies(_searchController.text);
    }
  }

  Future<void> _navigateToDetail(Company company) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyDetailScreen(company: company),
      ),
    );

    // Refresh list if returned (e.g. after delete)
    if (result == true) {
      _filterCompanies(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投资组合'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索公司或行业...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _filterCompanies,
            ),
          ),
          Expanded(
            child: _filteredCompanies.isEmpty
                ? const Center(child: Text('暂无相关公司'))
                : ListView.builder(
                    itemCount: _filteredCompanies.length,
                    itemBuilder: (context, index) {
                      final company = _filteredCompanies[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Text(
                              company.name.isNotEmpty ? company.name.substring(0, 1) : '?',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            company.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${company.sector} • ${company.stage}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '¥${company.investmentAmount}M',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                company.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: company.status == 'Active' ? Colors.blue : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _navigateToDetail(company),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddCompany,
        child: const Icon(Icons.add),
      ),
    );
  }
}
