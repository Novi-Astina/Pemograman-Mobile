import 'package:flutter/material.dart';
import '../models/feedback_model.dart';

class FeedbackProvider extends ChangeNotifier {
  // Data feedback yang sedang diisi
  FeedbackModel _feedback = FeedbackModel();
  
  // Riwayat semua feedback yang sudah disubmit
  final List<FeedbackModel> _feedbackHistory = [];
  
  // Getter untuk mengakses data
  FeedbackModel get feedback => _feedback;
  List<FeedbackModel> get feedbackHistory => _feedbackHistory;
  
  // Update data mahasiswa
  void updateName(String name) {
    _feedback.name = name;
    notifyListeners();
  }
  
  void updateNim(String nim) {
    _feedback.nim = nim;
    notifyListeners();
  }
  
  void updateProdi(String prodi) {
    _feedback.prodi = prodi;
    notifyListeners();
  }
  
  void updateSemester(int semester) {
    _feedback.semester = semester;
    notifyListeners();
  }
  
  // Update rating fasilitas
  void updatePerpustakaanRating(int rating) {
    _feedback.perpustakaanRating = rating;
    notifyListeners();
  }
  
  void updateLabRating(int rating) {
    _feedback.labRating = rating;
    notifyListeners();
  }
  
  void updateKantinRating(int rating) {
    _feedback.kantinRating = rating;
    notifyListeners();
  }
  
  void updateToiletRating(int rating) {
    _feedback.toiletRating = rating;
    notifyListeners();
  }
  
  void updateParkirRating(int rating) {
    _feedback.parkirRating = rating;
    notifyListeners();
  }
  
  // Update rating layanan
  void updateDosenRating(int rating) {
    _feedback.dosenRating = rating;
    notifyListeners();
  }
  
  void updateStaffRating(int rating) {
    _feedback.staffRating = rating;
    notifyListeners();
  }
  
  void updateAdministrasiRating(int rating) {
    _feedback.administrasiRating = rating;
    notifyListeners();
  }
  
  // Update saran
  void updateSaran(String saran) {
    _feedback.saran = saran;
    notifyListeners();
  }
  
  // Submit feedback ke history
  void submitFeedback() {
    // Buat copy dari feedback saat ini
    _feedbackHistory.add(FeedbackModel(
      name: _feedback.name,
      nim: _feedback.nim,
      prodi: _feedback.prodi,
      semester: _feedback.semester,
      perpustakaanRating: _feedback.perpustakaanRating,
      labRating: _feedback.labRating,
      kantinRating: _feedback.kantinRating,
      toiletRating: _feedback.toiletRating,
      parkirRating: _feedback.parkirRating,
      dosenRating: _feedback.dosenRating,
      staffRating: _feedback.staffRating,
      administrasiRating: _feedback.administrasiRating,
      saran: _feedback.saran,
    ));
    notifyListeners();
  }
  
  // Reset feedback untuk input baru
  void resetFeedback() {
    _feedback = FeedbackModel();
    notifyListeners();
  }
  
  // Hapus history berdasarkan index
  void deleteHistory(int index) {
    if (index >= 0 && index < _feedbackHistory.length) {
      _feedbackHistory.removeAt(index);
      notifyListeners();
    }
  }
  
  // Hapus semua history
  void clearHistory() {
    _feedbackHistory.clear();
    notifyListeners();
  }
}