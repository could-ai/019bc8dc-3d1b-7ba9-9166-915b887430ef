import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/company.dart';
import '../data/mock_data.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController();
  final _sectorController = TextEditingController();
  final _stageController = TextEditingController();
  final _investmentController = TextEditingController();
  final _valuationController = TextEditingController();
  final _founderController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  String _status = 'Active';
  
  final List<String> _statusOptions = ['Active', 'Exited', 'Written Off'];

  @override
  void dispose() {
    _nameController.dispose();
    _sectorController.dispose();
    _stageController.dispose();
    _investmentController.dispose();
    _valuationController.dispose();
    _founderController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newCompany = Company(
        id: const Uuid().v4(),
        name: _nameController.text,
        sector: _sectorController.text,
        stage: _stageController.text,
        investmentAmount: double.parse(_investmentController.text),
        valuation: double.parse(_valuationController.text),
        founder: _founderController.text,
        investmentDate: _selectedDate,
        description: _descriptionController.text,
        status: _status,
      );

      MockData.addCompany(newCompany);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('公司添加成功')),
      );
      
      Navigator.pop(context, true); // Return true to indicate success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加新公司'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('基本信息'),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '公司名称',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入公司名称';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _sectorController,
                      decoration: const InputDecoration(
                        labelText: '行业领域',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      validator: (value) => value!.isEmpty ? '请输入行业' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _stageController,
                      decoration: const InputDecoration(
                        labelText: '融资轮次',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.timeline),
                      ),
                      validator: (value) => value!.isEmpty ? '请输入轮次' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _founderController,
                decoration: const InputDecoration(
                  labelText: '创始人',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? '请输入创始人姓名' : null,
              ),
              
              const SizedBox(height: 24),
              _buildSectionTitle('财务数据 (百万 ¥)'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _investmentController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '投资金额',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        suffixText: 'M',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return '请输入金额';
                        if (double.tryParse(value) == null) return '请输入有效数字';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _valuationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '当前估值',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.trending_up),
                        suffixText: 'M',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return '请输入估值';
                        if (double.tryParse(value) == null) return '请输入有效数字';
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('其他详情'),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: '投资日期',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: '运营状态',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.info_outline),
                ),
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: '公司简介',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                validator: (value) => value!.isEmpty ? '请输入简介' : null,
              ),
              
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('保存公司信息', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
