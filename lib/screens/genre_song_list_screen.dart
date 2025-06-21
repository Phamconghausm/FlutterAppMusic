import 'package:flutter/material.dart';
import 'all_song_screen.dart';

class GenreSongListScreen extends StatelessWidget {
  final List<String> genres;
  const GenreSongListScreen({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
        backgroundColor: const Color(0xFF920A92),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAFEEEE), Color(0xFF920A92)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: genres.length,
          itemBuilder: (context, index) {
            final genre = genres[index];
            return ListTile(
              leading: const Icon(Icons.library_music, color: Colors.white),
              title: Text(genre, style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllSongsScreen(genre: genre),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}