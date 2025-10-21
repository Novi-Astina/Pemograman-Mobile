import 'package:flutter/material.dart';
import 'detail_page.dart';

void main() {
  runApp(const ProfilDosenApp());
}

class ProfilDosenApp extends StatelessWidget {
  const ProfilDosenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Dosen App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 145, 161, 255)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> dosenList = const [
    {
      "nama": "Dr. Endrew Alex, M.Kom",
      "jabatan": "Dosen Pemrograman",
      "foto":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "email": "Endrew16@kampus.ac.id",
      "telepon": "08647388990",
      "bio":
          "Dosen dengan pengalaman lebih dari 10 tahun di bidang pengembangan perangkat lunak dan kecerdasan buatan."
    },
    {
      "nama": "Ir. Shandra Amallya, M.T",
      "jabatan": "Dosen Jaringan Komputer",
      "foto":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
      "email": "shandra amallya@kampus.ac.id",
      "telepon": "08129865432",
      "bio":
          "Spesialis dalam bidang jaringan komputer, keamanan siber, dan komunikasi data."
    },
    {
      "nama": "Drs. Rizky Adha, M.Kom",
      "jabatan": "Dosen Basis Data",
      "foto":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "email": "RizkyAdha@kampus.ac.id",
      "telepon": "0812876545634",
      "bio":
          "Ahli dalam desain dan optimasi basis data, serta pengajaran SQL dan sistem informasi."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Daftar Dosen"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 154, 169, 255),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: dosenList.length,
          itemBuilder: (context, index) {
            final dosen = dosenList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(dosen: dosen),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.network(
                        dosen["foto"]!,
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dosen["nama"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 166, 180, 255),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              dosen["jabatan"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.arrow_forward_ios_rounded,
                                    color: Colors.indigo, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "Lihat Profil",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 101, 124, 255),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
