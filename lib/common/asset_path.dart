enum SoundAssetPath {
  defaultSound("assets/sounds/0.mp3", "알람 1"),
  electronic("assets/sounds/1.mp3", "알람 2"),
  marimbaShort("assets/sounds/2.mp3", "알람 3"),
  marimbaMedium("assets/sounds/3.mp3", "알람 4"),
  marimbaLong("assets/sounds/4.mp3", "알람 5"),
  shortMelody("assets/sounds/5.mp3", "알람 6"),
  ringtone("assets/sounds/6.mp3", "알람 7"),
  ringtoneIncomingPhone("assets/sounds/7.mp3", "알람 8");

  final String path;
  final String name;

  const SoundAssetPath(this.path, this.name);
}
