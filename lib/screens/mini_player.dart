import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_player_service.dart';
import 'a_song_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioPlayerService>(context);
    final song = audioService.currentSong;
    if (song == null) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ASongScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.97),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.purple[100],
                  width: 44,
                  height: 44,
                  child: const Icon(Icons.music_note, color: Colors.purple, size: 30),
                ),
              ),
              const SizedBox(width: 10),
              // Thông tin bài hát
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title ?? song.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    if (song.genre != null && song.genre!.isNotEmpty)
                      Text(
                        song.genre!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    // Dòng nút điều khiển
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              audioService.isShuffle ? Icons.shuffle_on : Icons.shuffle,
                              color: audioService.isShuffle ? Colors.purple : Colors.grey,
                              size: 18,
                            ),
                            onPressed: audioService.toggleShuffle,
                            tooltip: 'Shuffle',
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_previous, color: Colors.black87, size: 20),
                            onPressed: audioService.previous,
                            tooltip: 'Previous',
                          ),
                          IconButton(
                            icon: Icon(
                              audioService.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              color: Colors.purple,
                              size: 26,
                            ),
                            onPressed: () {
                              audioService.isPlaying ? audioService.pause() : audioService.play();
                            },
                            tooltip: audioService.isPlaying ? 'Pause' : 'Play',
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next, color: Colors.black87, size: 20),
                            onPressed: audioService.next,
                            tooltip: 'Next',
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.repeat,
                              color: audioService.isRepeat ? Colors.purple : Colors.grey,
                              size: 18,
                            ),
                            onPressed: audioService.toggleRepeat,
                            tooltip: 'Repeat',
                          ),
                          // Nút X để tắt mini player
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                            tooltip: 'Đóng',
                            onPressed: () {
                              audioService.stopAndClear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}