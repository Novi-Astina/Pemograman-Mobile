class FeedbackModel {
  // Data Mahasiswa
  String name;
  String nim;
  String prodi;
  int semester;
  
  // Rating untuk fasilitas (1-5 bintang)
  int perpustakaanRating;
  int labRating;
  int kantinRating;
  int toiletRating;
  int parkirRating;
  
  // Rating untuk layanan (1-5 bintang)
  int dosenRating;
  int staffRating;
  int administrasiRating;
  
  // Saran dan kritik
  String saran;
  
  // Constructor
  FeedbackModel({
    this.name = '',
    this.nim = '',
    this.prodi = '',
    this.semester = 1,
    this.perpustakaanRating = 0,
    this.labRating = 0,
    this.kantinRating = 0,
    this.toiletRating = 0,
    this.parkirRating = 0,
    this.dosenRating = 0,
    this.staffRating = 0,
    this.administrasiRating = 0,
    this.saran = '',
  });
  
  // Hitung rata-rata rating fasilitas
  double get fasilitasAverage {
    if (perpustakaanRating == 0 && labRating == 0 && kantinRating == 0 && 
        toiletRating == 0 && parkirRating == 0) {
      return 0;
    }
    return (perpustakaanRating + labRating + kantinRating + toiletRating + parkirRating) / 5;
  }
  
  // Hitung rata-rata rating layanan
  double get layananAverage {
    if (dosenRating == 0 && staffRating == 0 && administrasiRating == 0) {
      return 0;
    }
    return (dosenRating + staffRating + administrasiRating) / 3;
  }
  
  // Hitung rata-rata keseluruhan
  double get overallAverage {
    if (fasilitasAverage == 0 && layananAverage == 0) {
      return 0;
    }
    return (fasilitasAverage + layananAverage) / 2;
  }
  
  // Cek apakah semua data sudah lengkap
  bool get isComplete {
    return name.isNotEmpty &&
        nim.isNotEmpty &&
        prodi.isNotEmpty &&
        perpustakaanRating > 0 &&
        labRating > 0 &&
        kantinRating > 0 &&
        toiletRating > 0 &&
        parkirRating > 0 &&
        dosenRating > 0 &&
        staffRating > 0 &&
        administrasiRating > 0;
  }
  
  // Copy method untuk membuat duplikat
  FeedbackModel copyWith({
    String? name,
    String? nim,
    String? prodi,
    int? semester,
    int? perpustakaanRating,
    int? labRating,
    int? kantinRating,
    int? toiletRating,
    int? parkirRating,
    int? dosenRating,
    int? staffRating,
    int? administrasiRating,
    String? saran,
  }) {
    return FeedbackModel(
      name: name ?? this.name,
      nim: nim ?? this.nim,
      prodi: prodi ?? this.prodi,
      semester: semester ?? this.semester,
      perpustakaanRating: perpustakaanRating ?? this.perpustakaanRating,
      labRating: labRating ?? this.labRating,
      kantinRating: kantinRating ?? this.kantinRating,
      toiletRating: toiletRating ?? this.toiletRating,
      parkirRating: parkirRating ?? this.parkirRating,
      dosenRating: dosenRating ?? this.dosenRating,
      staffRating: staffRating ?? this.staffRating,
      administrasiRating: administrasiRating ?? this.administrasiRating,
      saran: saran ?? this.saran,
    );
  }
}