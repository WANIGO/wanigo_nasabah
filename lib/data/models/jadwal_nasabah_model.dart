<<<<<<< HEAD
=======
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

>>>>>>> 71672f60608a6d4e32b2972b518c2f4590435ad6
class JadwalNasabahModel {
  final int day;
  final String month;
  final String weekday;
<<<<<<< HEAD
  final List<JadwalDetail> jadwalList;
=======
  final List<JadwalItem> jadwalList;
>>>>>>> 71672f60608a6d4e32b2972b518c2f4590435ad6

  JadwalNasabahModel({
    required this.day,
    required this.month,
    required this.weekday,
    required this.jadwalList,
  });
<<<<<<< HEAD
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
=======
}
>>>>>>> 71672f60608a6d4e32b2972b518c2f4590435ad6
