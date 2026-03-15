# clpkg-audio-editor — Specification

## Overview

Coalton-first typed domain model for an audio editor within CL-EMACS.
Provides ADTs for audio format handling, WAV parsing, and multi-format metadata.

## Modules

### `Core.Formats` — Audio format ADTs
- `SampleFormat`, `AudioFormat`, `WavHeader`, `FlacStreamInfo`, `OggPage`, `Mp3FrameHeader`, `FormatResult`

### `Core.WavParser` — WAV serialization
- `serialize-wav-header`, `wav-duration-ms`

### `Core.Metadata` — Multi-format detection
- `parse-flac-streaminfo`, `parse-ogg-page`, `parse-mp3-frame-header`, `detect-format`

## Security Considerations

- **Format validation**: All parsers return `FormatResult` (total, no exceptions).
- **No file I/O in ADTs**: Pure domain model; file access is runtime concern.
- **Size bounds**: Integer fields prevent unbounded allocation.

## Performance Budget

| Operation | Target |
|-----------|--------|
| WAV header construction | < 1μs |
| Duration calculation | < 100ns |
| Format detection | < 1μs |
| Surface verification | < 2s |

## Future Work

- AIFF format types
- Audio effect ADTs (EQ, compression, reverb)
- Waveform display data types
- Edit operation types (cut, copy, paste, fade)
