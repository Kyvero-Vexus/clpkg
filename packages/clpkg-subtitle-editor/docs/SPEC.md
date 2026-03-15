# clpkg-subtitle-editor — Specification

## Overview

Coalton-first typed domain model for subtitle editing within CL-EMACS.
Supports SRT, VTT, and ASS/SSA formats with typed parsers and serializers.

## Modules

### `Core.Formats` — 13 ADTs
Timestamp, TimedCue, SubtitleFormat, CueStyle, StyleTag, SrtEntry, VttCue, VttHeader,
AssStyle, AssDialogue, AssScript, ParseResult + SubtitleFormat detection.

### `Core.SrtParser` — SRT format
`parse-srt`, `serialize-srt`, `srt-entry-count`

### `Core.VttParser` — WebVTT format
`parse-vtt`, `serialize-vtt`, `vtt-cue-count`

### `Core.AssParser` — ASS/SSA format
`parse-ass`, `serialize-ass`, `ass-dialogue-count`

## Security

- All parsers return total `ParseResult` (no exceptions)
- No file I/O in ADTs
- Timestamp bounds validated by construction

## Future Work

- TTML/DFXP support
- Subtitle timing adjustment tools
- Character encoding detection
