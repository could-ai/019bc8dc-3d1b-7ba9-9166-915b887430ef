class Company {
  final String id;
  final String name;
  final String sector; // 行业 (e.g., AI, SaaS, BioTech)
  final String stage; // 轮次 (e.g., Seed, Series A)
  final double investmentAmount; // 投资金额 (in millions)
  final double valuation; // 当前估值 (in millions)
  final String founder;
  final DateTime investmentDate;
  final String description;
  final String status; // 运营状态 (Active, Exited, Written Off)

  Company({
    required this.id,
    required this.name,
    required this.sector,
    required this.stage,
    required this.investmentAmount,
    required this.valuation,
    required this.founder,
    required this.investmentDate,
    required this.description,
    required this.status,
  });
}
