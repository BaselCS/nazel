# ACTIVE_SKILLS.md — Nazel Greenfield Flutter Stack

> Project stage: architecture & planning (idea phase).
> Source of truth: `/home/basel/Work/my_skills` symlinked into `.agent/skills/<skill_id>`.
> These rules are inviolable project constraints for all subsequent code generation.

## Summary

- **Total mounted skills:** 17
- **Total token budget consumption:** 12836 tokens
- **Conflict status:** ✅ CLEAR — no conflicting skills present.
  - `flutter-use-dio` active, `flutter-use-http-package` explicitly excluded.
  - `flutter-state-stacked-mvvm` active, `flutter-state-bloc` explicitly excluded.
  - `flutter-storage-drift` active, `flutter-storage-objectbox` not mounted.

## Mounted Skills

| Skill ID | Category | Token Budget | Primary Architectural Rule |
|---|---|---:|---|
| `flutter-apply-architecture-best-practices` | Architecture & UI Foundations | 695 | Layered feature-first folders; strict UI/business-logic separation |
| `flutter-build-responsive-layout` | Architecture & UI Foundations | 668 | Responsive/adaptive layouts from day one (no fixed-pixel assumptions) |
| `flutter-fix-layout-issues` | Architecture & UI Foundations | 658 | Diagnose constraint violations; forbid common layout anti-patterns |
| `flutter-setup-localization` | Architecture & UI Foundations | 672 | `flutter_localizations` + codegen setup; no hardcoded strings |
| `arabic-rtl` | Architecture & UI Foundations | 400 | Directional widgets (`EdgeInsetsDirectional`, `AlignmentDirectional`); full RTL flipping |
| `flutter-setup-declarative-routing` | Architecture & UI Foundations | 691 | Declarative routing (go_router); deep-link-ready route table |
| `flutter-use-dio` | Data & Networking | 1200 | Dio-only HTTP with queued 401 token-refresh, timeouts, retries; `flutter-use-http-package` banned |
| `flutter-implement-json-serialization` | Data & Networking | 688 | Manual/DTO serialization standards; typed models for all API payloads |
| `dart-use-pattern-matching` | Data & Networking | 695 | Dart 3 patterns + sealed `Result` handling; no unchecked casts |
| `flutter-storage-drift` | Data & Networking | 1200 | Drift/SQLite offline-first in background isolate; reactive streams + migrations |
| `flutter-state-stacked-mvvm` | State Management | 1200 | Stacked MVVM only: logic lives in ViewModels, DI via Locator; `flutter-state-bloc` banned |
| `flutter-add-widget-test` | Testing & Quality | 681 | Widget test per new widget/screen behavior |
| `flutter-add-integration-test` | Testing & Quality | 692 | Integration coverage for critical user flows |
| `dart-run-static-analysis` | Testing & Quality | 691 | `flutter analyze` gate; zero-warning policy with tuned `analysis_options.yaml` |
| `dart-fix-runtime-errors` | Testing & Quality | 667 | Null-safety + sound typing; structured runtime-error triage |
| `caveman` | Token Efficiency | 644 | Ultra-compressed technical communication |
| `performance-analysis` | Performance & Quality | 694 | Frame rate profiling, memory leak detection, rebuild optimization |

## Active Architectural Stack (Confirmation)

1. **Architecture:** feature-first layered structure (`flutter-apply-architecture-best-practices`).
2. **UI:** responsive layouts + layout-error discipline + declarative routing.
3. **i18n/RTL:** `flutter-setup-localization` + `arabic-rtl` companion for Arabic-first UI.
4. **State:** Stacked MVVM exclusively (no BLoC).
5. **Networking:** Dio exclusively (queued token rotation, no `http` package).
6. **Serialization:** DTO standards + Dart 3 pattern-matched `Result`.
7. **Persistence:** Drift offline-first (default choice; ObjectBox not mounted).
8. **Quality gates:** static analysis + runtime-error triage + widget/integration tests.

## Maintenance

- Add new skills only via symlink from `/home/basel/Work/my_skills`; never copy files.
- Before adding a state/networking/storage skill, check `conflicts_with` in its `SKILL.md` frontmatter.
- After any mount/unmount, update the count + token total in this manifest.
