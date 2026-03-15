# clpkg-livestream-encoder — Specification

## Overview

Coalton-first typed domain model for livestream encoding within CL-EMACS.
Supports RTMP, HLS, and FLV protocols with typed frame/segment constructors.

## Modules

### `Core.Protocols` — 14 ADTs
StreamProtocol, Bitrate, StreamConfig, RtmpChunkType, RtmpChunk, RtmpHandshake,
HlsSegment, HlsPlaylist, HlsPlaylistType, FlvTag, FlvTagType, FlvHeader, FrameResult, StreamConfig.

### `Core.RtmpFrames` — RTMP
`make-rtmp-chunk`, `make-handshake-c0`, `make-handshake-c1`, `rtmp-chunk-header-size`, `serialize-rtmp-chunk`

### `Core.HlsSegments` — HLS
`make-hls-segment`, `make-hls-playlist`, `hls-segment-count`, `serialize-hls-playlist`

### `Core.FlvTags` — FLV
`make-flv-header`, `make-flv-tag`, `flv-tag-type-id`, `serialize-flv-header`

## Security

- Protocol ADTs are total (no partial constructors)
- No network I/O in domain model
- Handshake types model RTMP security negotiation

## Future Work

- SRT (Secure Reliable Transport) protocol
- DASH (Dynamic Adaptive Streaming) types
- Codec configuration ADTs (H.264/H.265/AV1)
