# clpkg-daw — Specification

## Overview

Coalton-first typed domain model for a Digital Audio Workstation within CL-EMACS.
Provides ADTs for session management, mixer channels, and transport control.

## Modules

### `Core.Session` (8 ADTs)
- `SampleRate`, `BitDepth`, `SessionConfig`, `Track`, `TrackType`, `Region`, `SessionState`, `SessionResult`

### `Core.Mixer` (7 ADTs)
- `PanLaw`, `ChannelType`, `MixerChannel`, `Bus`, `SendType`, `Send`, `MixerResult`

### `Core.Transport` (5 ADTs + 4 functions)
- `TransportMode`, `LoopRegion`, `TransportState`, `TransportCommand`, `TransportResult`
- `transport-is-playing`, `transport-is-recording`, `transport-position-bars`, `apply-transport-command`

## Security Considerations

- **Session file isolation**: Each session operates on a single project directory.
- **No network access**: Pure domain model; audio I/O is runtime concern.
- **Resource limits**: `SessionConfig` defines sample rate and bit depth bounds.

## Performance Budget

| Operation | Target |
|-----------|--------|
| Transport state match | < 100ns |
| Position calculation | < 100ns (integer division) |
| ADT construction | < 1μs |
| Surface verification | < 2s |

## Future Work

- MIDI message types
- Plugin/VST hosting ADTs
- Automation lane types
- Audio effect chain types
