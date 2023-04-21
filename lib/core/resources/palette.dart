import 'package:flutter/material.dart';

// 100% — FF  ##  50% — 80
// 99% — FC   ## 49% — 7D
// 98% — FA   ## 48% — 7A
// 97% — F7   ## 47% — 78
// 96% — F5   ## 46% — 75
// 95% — F2   ## 45% — 73
// 94% — F0   ## 44% — 70
// 93% — ED   ## 43% — 6E
// 92% — EB   ## 42% — 6B
// 91% — E8   ## 41% — 69
// 90% — E6   ## 40% — 66
// 89% — E3   ## 39% — 63
// 88% — E0   ## 38% — 61
// 87% — DE   ## 37% — 5E
// 86% — DB   ## 36% — 5C
// 85% — D9   ## 35% — 59
// 84% — D6   ## 34% — 57
// 83% — D4   ## 33% — 54
// 82% — D1   ## 32% — 52
// 81% — CF   ## 31% — 4F
// 80% — CC   ## 30% — 4D
// 79% — C9   ## 29% — 4A
// 78% — C7   ## 28% — 47
// 77% — C4   ## 27% — 45
// 76% — C2   ## 26% — 42
// 75% — BF   ## 25% — 40
// 74% — BD   ## 24% — 3D
// 73% — BA   ## 23% — 3B
// 72% — B8   ## 22% — 38
// 71% — B5   ## 21% — 36
// 70% — B3   ## 20% — 33
// 69% — B0   ## 19% — 30
// 68% — AD   ## 18% — 2E
// 67% — AB   ## 17% — 2B
// 66% — A8   ## 16% — 29
// 65% — A6   ## 15% — 26
// 64% — A3   ## 14% — 24
// 63% — A1   ## 13% — 21
// 62% — 9E   ## 12% — 1F
// 61% — 9C   ## 11% — 1C
// 60% — 99   ## 10% — 1A
// 59% — 96   ## 9% — 17
// 58% — 94   ## 8% — 14
// 57% — 91   ## 7% — 12
// 56% — 8F   ## 6% — 0F
// 55% — 8C   ## 5% — 0D
// 54% — 8A   ## 4% — 0A
// 53% — 87   ## 3% — 08
// 52% — 85   ## 2% — 05
// 51% — 82   ## 1% — 03

abstract class Palette {
  static Palette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? PaletteLight._()
          : PaletteDark._();

  Color get background;
  Color get foreground;
  Color get primary;
  Color get secondary;
  static const accent = Color(0xFF1A5CFF);
  Color get buttonAccent;
  Color get error;
  Color get success;

  static const Color white = Color(0xffffffff);
  static const Color black10 = Color(0x1A000000);
  static const Color black15 = Color(0x26000000);
  static const Color black20 = Color(0x33000000);
  static const Color black25 = Color(0x40000000);
  static const Color black = Color(0xFF000000);
  static const Color disable = Color(0x801D3066);
}

class PaletteLight extends Palette {
  PaletteLight._();

  @override
  final Color background = const Color(0xFFf9f9f9);
  @override
  final Color foreground = const Color(0xFF262931);
  @override
  final Color primary = const Color(0xFF4a55a7);
  @override
  final Color secondary = const Color(0xFFBFDBFE);
  @override
  final Color buttonAccent = Palette.accent;
  @override
  final Color error = const Color(0xFFE12E0D);
  @override
  final Color success = const Color(0xFF00B37E);
}

class PaletteDark extends Palette {
  PaletteDark._();

  @override
  final Color background = const Color(0xFF181818);
  @override
  final Color foreground = const Color(0xFFFFFFFF);
  @override
  final Color primary = const Color(0xFF6371DE);
  @override
  final Color secondary = const Color(0xFF1E293B);
  @override
  final Color buttonAccent = const Color(0xFFFFFFFF);
  @override
  final Color error = const Color(0xFFE12E0D);
  @override
  final Color success = const Color(0xFF00B37E);
}
