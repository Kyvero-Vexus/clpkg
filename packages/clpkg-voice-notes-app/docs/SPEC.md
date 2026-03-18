# clpkg-voice-notes-app — Specification

Scaffold for deterministic voice-note ingest pipeline.

## Pipeline Stages
1. Ingest audio payload + metadata.
2. Transcribe to normalized transcript.
3. Validate transcript + policy constraints.
4. Index note for retrieval.
5. Emit immutable note artifact.

## Deterministic Note ID Strategy
`note-id = sha256(source-uri || captured-at-unix || codec || payload-bytes)`

## Public Contracts (baseline)
- `ingest-note` returns `PipelineResult VoiceNoteDraft`
- `transcribe-note` returns `PipelineResult VoiceNoteTranscript`
- `validate-note` returns `PipelineResult VoiceNoteValidated`
- `index-note` returns `PipelineResult VoiceNoteIndexed`
- `emit-note` returns `PipelineResult VoiceNoteArtifact`
