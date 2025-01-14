class ProductivitySample {
  final double smv;
  final double wip;
  final double overTime;
  final double incentive;
  final double idleTime;
  final int idleMen;
  final int noOfWorkers;
  final int quarter;
  final String department;
  final String day;
  final int team;
  final int noOfStyleChange;

  ProductivitySample({
    required this.smv,
    required this.wip,
    required this.overTime,
    required this.incentive,
    required this.idleTime,
    required this.idleMen,
    required this.noOfWorkers,
    required this.quarter,
    required this.department,
    required this.day,
    required this.team,
    required this.noOfStyleChange,
  });

  Map<String, dynamic> toMap() => {
        'smv': smv,
        'wip': wip,
        'over_time': overTime,
        'incentive': incentive,
        'idle_time': idleTime,
        'idle_men': idleMen,
        'no_of_workers': noOfWorkers,
        'quarter': quarter,
        'department': department,
        'day': day,
        'team': team,
        'no_of_style_change': noOfStyleChange,
      };

  factory ProductivitySample.fromMap(Map<String, dynamic> map) => ProductivitySample(
        smv: map['smv']?.toDouble() ?? 0.0,
        wip: map['wip']?.toDouble() ?? 0.0,
        overTime: map['over_time']?.toDouble() ?? 0.0,
        incentive: map['incentive']?.toDouble() ?? 0.0,
        idleTime: map['idle_time']?.toDouble() ?? 0.0,
        idleMen: map['idle_men']?.toInt() ?? 0,
        noOfWorkers: map['no_of_workers']?.toInt() ?? 0,
        quarter: map['quarter']?.toInt() ?? 0,
        department: map['department'] ?? '',
        day: map['day'] ?? '',
        team: map['team']?.toInt() ?? 0,
        noOfStyleChange: map['no_of_style_change']?.toInt() ?? 0,
      );

  String get summary => 'Team $team | $department | $day\nWorkers: $noOfWorkers | SMV: $smv';
}

final List<ProductivitySample> sampleData = [
  ProductivitySample(
    smv: 5.2,
    wip: 10.5,
    overTime: 2,
    incentive: 1.5,
    idleTime: 0.5,
    idleMen: 3,
    noOfWorkers: 50,
    quarter: 1,
    department: "finishing",
    day: "Monday",
    team: 1,
    noOfStyleChange: 2,
  ),
  ProductivitySample(
    smv: 4.8,
    wip: 8.0,
    overTime: 1,
    incentive: 2.0,
    idleTime: 0.3,
    idleMen: 2,
    noOfWorkers: 45,
    quarter: 2,
    department: "sewing",
    day: "Tuesday",
    team: 2,
    noOfStyleChange: 1,
  ),
  ProductivitySample(
    smv: 6.0,
    wip: 12.0,
    overTime: 3,
    incentive: 1.8,
    idleTime: 0.7,
    idleMen: 4,
    noOfWorkers: 55,
    quarter: 3,
    department: "finishing",
    day: "Wednesday",
    team: 3,
    noOfStyleChange: 3,
  ),
  ProductivitySample(
    smv: 5.5,
    wip: 9.5,
    overTime: 2.5,
    incentive: 1.2,
    idleTime: 0.4,
    idleMen: 2,
    noOfWorkers: 48,
    quarter: 4,
    department: "sewing",
    day: "Thursday",
    team: 4,
    noOfStyleChange: 1,
  ),
];
