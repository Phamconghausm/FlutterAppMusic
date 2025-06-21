import 'package:flutter/material.dart';
import 'package:music_streaming_app/screens/all_song_screen.dart';
import 'package:music_streaming_app/screens/audio_player_service.dart';
import 'package:music_streaming_app/screens/mini_player.dart';
import 'package:provider/provider.dart';
import 'a_song_screen.dart';
import 'home_screen.dart';

class PlaylistSongListScreen extends StatelessWidget {
  final String playlistName;
  final List<Music> songs; // Đổi sang List<Music>
  const PlaylistSongListScreen(
      {super.key, required this.playlistName, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlistName),
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
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return ListTile(
              leading: safeNetworkImage(song.url), // Nếu có ảnh riêng thì sửa lại
              title: Text(song.name,
                  style: TextStyle(
                      color: Colors.white.withAlpha((0.9 * 255).toInt()))),
              onTap: () {
                final audioService = Provider.of<AudioPlayerService>(context, listen: false);
                audioService.playPlaylist(songs, index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ASongScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
