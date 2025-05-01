class JadwalItem {
  final String title;
  final String date;
  final String color;

  JadwalItem({
    required this.title,
    required this.date,
    required this.color,
  });
}

class JadwalNasabahModel {
  final int day;
  final String month;
  final String weekday;
  final List<JadwalItem> jadwalList;

  JadwalNasabahModel({
    required this.day,
    required this.month,
    required this.weekday,
    required this.jadwalList,
  });
}