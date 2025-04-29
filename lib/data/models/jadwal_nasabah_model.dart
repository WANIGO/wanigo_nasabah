class JadwalNasabahModel {
  final int day;
  final String month;
  final String weekday;
  final List<JadwalDetail> jadwalList;

  JadwalNasabahModel({
    required this.day,
    required this.month,
    required this.weekday,
    required this.jadwalList,
  });
}

class JadwalDetail {
  final String title;
  final String date;
  final String color; // hex string e.g. "#00A86B"

  JadwalDetail({
    required this.title,
    required this.date,
    required this.color,
  });
}
