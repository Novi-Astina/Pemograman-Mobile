import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feedback_provider.dart';
import '../utils/app_theme.dart';
import 'fasilitas_screen.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({super.key});

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  
  String? _selectedProdi;
  int _selectedSemester = 1;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final List<String> _prodiList = [
    'ekonomi Syariah',
    'Sistem Informasi',
    'Kimia',
    'Akuntansi syariah',
    'Hukum tata Negara',
    'Manajemen',
    'Fisika',
    'Keguruan',
    'Psikologi',
    'Ilmu Komunikasi',
  ];

  @override
  void initState() {
    super.initState();
    
    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
    
    // Load data yang sudah ada
    final provider = Provider.of<FeedbackProvider>(context, listen: false);
    _nameController.text = provider.feedback.name;
    _nimController.text = provider.feedback.nim;
    _selectedProdi = provider.feedback.prodi.isEmpty ? null : provider.feedback.prodi;
    _selectedSemester = provider.feedback.semester;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header dengan icon
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              shape: BoxShape.circle,
                              boxShadow: AppTheme.cardShadow,
                            ),
                            child: const Icon(
                              Icons.person_add_rounded,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Judul
                        const Center(
                          child: Text(
                            'Lengkapi Data Diri',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkBlue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Isi data diri Anda sebelum melanjutkan',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Card untuk form
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: AppTheme.cardShadow,
                          ),
                          child: Column(
                            children: [
                              // Input Nama
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nama Lengkap',
                                  hintText: 'Masukkan nama lengkap',
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    color: AppTheme.primarySoftBlue,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: AppTheme.darkBlue,
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama tidak boleh kosong';
                                  }
                                  if (value.length < 3) {
                                    return 'Nama minimal 3 karakter';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              
                              // Input NIM
                              TextFormField(
                                controller: _nimController,
                                decoration: InputDecoration(
                                  labelText: 'NIM',
                                  hintText: 'Masukkan NIM',
                                  prefixIcon: Icon(
                                    Icons.badge_rounded,
                                    color: AppTheme.primarySoftBlue,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: AppTheme.darkBlue,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'NIM tidak boleh kosong';
                                  }
                                  if (value.length < 8) {
                                    return 'NIM minimal 8 digit';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              
                              // Dropdown Program Studi
                              DropdownButtonFormField<String>(
                                value: _selectedProdi,
                                decoration: InputDecoration(
                                  labelText: 'Program Studi',
                                  prefixIcon: Icon(
                                    Icons.school_rounded,
                                    color: AppTheme.primarySoftBlue,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: AppTheme.darkBlue,
                                  ),
                                ),
                                hint: const Text('Pilih Program Studi'),
                                items: _prodiList.map((prodi) {
                                  return DropdownMenuItem(
                                    value: prodi,
                                    child: Text(prodi),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProdi = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Pilih program studi';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              
                              // Slider Semester
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightCyan.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              color: AppTheme.primarySoftBlue,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              'Semester',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.darkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: AppTheme.primaryGradient,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.primarySoftBlue.withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'Semester $_selectedSemester',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    SliderTheme(
                                      data: SliderThemeData(
                                        activeTrackColor: AppTheme.primarySoftBlue,
                                        inactiveTrackColor: AppTheme.lightCyan,
                                        thumbColor: AppTheme.primarySoftBlue,
                                        overlayColor: AppTheme.primarySoftBlue.withOpacity(0.2),
                                        thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 12,
                                        ),
                                        trackHeight: 6,
                                      ),
                                      child: Slider(
                                        value: _selectedSemester.toDouble(),
                                        min: 1,
                                        max: 14,
                                        divisions: 13,
                                        label: _selectedSemester.toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedSemester = value.toInt();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Tombol Lanjut
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final provider = Provider.of<FeedbackProvider>(
                                  context,
                                  listen: false,
                                );
                                provider.updateName(_nameController.text);
                                provider.updateNim(_nimController.text);
                                provider.updateProdi(_selectedProdi!);
                                provider.updateSemester(_selectedSemester);
                                
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        const FasilitasScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primarySoftBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              shadowColor: AppTheme.primarySoftBlue.withOpacity(0.4),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Lanjut ke Penilaian Fasilitas',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded, size: 24),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}