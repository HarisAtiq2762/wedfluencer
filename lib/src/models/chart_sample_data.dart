class ChartSampleData {
  String? labels;
  double bloodPressureYValue;
  double bodyTemperatureSeriesYValue;
  double spo2SeriesYValue;
  double heartRateSeriesYValue;
  ChartSampleData(
      {this.labels,
      required this.bloodPressureYValue,
      required this.bodyTemperatureSeriesYValue,
      required this.spo2SeriesYValue,
      required this.heartRateSeriesYValue});
}

class DoctorChartSampleData {
  String labels;
  double criticalYValue;
  double generalYValue;
  DoctorChartSampleData(
      {required this.labels,
      required this.generalYValue,
      required this.criticalYValue});
}

List<ChartSampleData> chartWeeklyData = <ChartSampleData>[
  ChartSampleData(
    labels: 'Mon',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Tue',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Wed',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Thu',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Fri',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Sat',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Sun',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
];
List<ChartSampleData> chartMonthlyData = <ChartSampleData>[
  ChartSampleData(
    labels: 'Jan',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Feb',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Mar',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Apr',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'May',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Jun',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Jul',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Aug',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Sep',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Oct',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: 'Nov',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: 'Dec',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
];
List<ChartSampleData> chartDailyData = <ChartSampleData>[
  ChartSampleData(
    labels: '1',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '2',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '3',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '4',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '5',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '6',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '7',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '8',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '9',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '10',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '11',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '12',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '13',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '14',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '15',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '16',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '17',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '18',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '19',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '20',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '21',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '22',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
  ChartSampleData(
    labels: '23',
    bloodPressureYValue: 55,
    bodyTemperatureSeriesYValue: 65,
    spo2SeriesYValue: 75,
    heartRateSeriesYValue: 85,
  ),
  ChartSampleData(
    labels: '24',
    bloodPressureYValue: 95,
    bodyTemperatureSeriesYValue: 100,
    spo2SeriesYValue: 105,
    heartRateSeriesYValue: 110,
  ),
];

List<DoctorChartSampleData> doctorChartWeeklyData = <DoctorChartSampleData>[
  DoctorChartSampleData(
    labels: 'Mon',
    generalYValue: 2,
    criticalYValue: 1,
  ),
  DoctorChartSampleData(
    labels: 'Tue',
    generalYValue: 4,
    criticalYValue: 0,
  ),
  DoctorChartSampleData(
    labels: 'Wed',
    generalYValue: 1,
    criticalYValue: 3,
  ),
  DoctorChartSampleData(
    labels: 'Thu',
    generalYValue: 6,
    criticalYValue: 0,
  ),
  DoctorChartSampleData(
    labels: 'Fri',
    generalYValue: 1,
    criticalYValue: 5,
  ),
  DoctorChartSampleData(
    labels: 'Sat',
    generalYValue: 9,
    criticalYValue: 3,
  ),
  DoctorChartSampleData(
    labels: 'Sun',
    generalYValue: 3,
    criticalYValue: 9,
  ),
];
List<DoctorChartSampleData> doctorChartMonthlyData = <DoctorChartSampleData>[
  DoctorChartSampleData(
    labels: 'Jan',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Feb',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: 'Mar',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Apr',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: 'May',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Jun',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: 'Jul',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Aug',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: 'Sep',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Oct',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: 'Nov',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: 'Dec',
    generalYValue: 95,
    criticalYValue: 100,
  ),
];
List<DoctorChartSampleData> doctorChartDailyData = <DoctorChartSampleData>[
  DoctorChartSampleData(
    labels: '1',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '2',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '3',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '4',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '5',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '6',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '7',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '8',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '9',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '10',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '11',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '12',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '13',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '14',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '15',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '16',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '17',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '18',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '19',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '20',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '21',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '22',
    generalYValue: 95,
    criticalYValue: 100,
  ),
  DoctorChartSampleData(
    labels: '23',
    generalYValue: 55,
    criticalYValue: 65,
  ),
  DoctorChartSampleData(
    labels: '24',
    generalYValue: 95,
    criticalYValue: 100,
  ),
];
