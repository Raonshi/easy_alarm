enum SoundAssetPath {
  defaultSound("assets/sound/0.mp3", "알람 1"),
  electronic("assets/sound/1.mp3", "알람 2"),
  marimbaShort("assets/sound/2.mp3", "알람 3"),
  marimbaMedium("assets/sound/3.mp3", "알람 4"),
  marimbaLong("assets/sound/4.mp3", "알람 5"),
  shortMelody("assets/sound/5.mp3", "알람 6"),
  ringtone("assets/sound/6.mp3", "알람 7"),
  ringtoneIncomingPhone("assets/sound/7.mp3", "알람 8");

  final String path;
  final String name;

  const SoundAssetPath(this.path, this.name);
}
