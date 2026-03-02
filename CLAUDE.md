# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter plugin package (`brick_lib`) serving as a shared library for Brick Converter and Brick Collector apps. Provides brick/LEGO data management, Rebrickable API integration, format conversion (CSV, BrickLink XML), and color/part mapping across platforms (Lego, BrickLink, Rebrickable, GoBricks).

## Common Commands

```bash
# Build generated code (Freezed, json_serializable, Isar)
dart run build_runner build --delete-conflicting-outputs

# Run all tests
flutter test

# Run a single test file
flutter test test/service/rebrickable_service_test.dart

# Lint/analyze
flutter analyze
```

There is also `scripts/buildGFiles.sh` which wraps the build_runner command, `scripts/git_tag.sh` for version tagging from pubspec.yaml, and `scripts/run_gobricks_update.sh` to update the GoBricks conversion table.

```bash
# Update GoBricks conversion table (scrapes mocbrickstore.com + yourwobb.com)
./scripts/run_gobricks_update.sh
```

## Architecture

Layered architecture with clear separation:

- **Models (`lib/model/`)** — Data classes using `@freezed` or `@JsonSerializable` with Isar `@embedded` annotations. Core types: `BrickPart`, `BrickColor`, `RebrickablePart`, `RebrickableColor`, `RebrickablePartCategory`.
- **Request (`lib/request/`)** — HTTP layer. Abstract `Request<T>` base class using Dio. Each subclass defines a `path` and `handleResponse()`. All hit the Rebrickable API (`https://rebrickable.com/api/v3`).
- **Service (`lib/service/`)** — `RebrickableService` orchestrates API calls (login, part details, colors, categories, user inventories) and applies excluded color/category filtering.
- **Logic (`lib/logic/`)** — `BrickConverterLogic` parses CSVs and maps parts/colors using asset tables. `BricklinkLogic` generates BrickLink XML inventory format.
- **UI (`lib/ui/`)** — Shared Flutter widgets (e.g., `GroupColors`).
- **Util (`lib/util/`)** — `Debug` utility with typed log levels and runtime toggles.

## Key Patterns

- **Dependency injection** via `get_it` (service locator pattern)
- **Code generation** is required after model changes — run build_runner to regenerate `.g.dart` and `.freezed.dart` files
- **CSV asset tables** (`assets/color_table.csv`, `assets/gobrick_conversion_table.csv`) drive color and part number mappings. The GoBricks table can be auto-updated via `scripts/update_gobricks_csv.py` (Python, requires `scripts/requirements.txt` deps)
- **Platform channels** named `brick_lib` for native integration across Android, iOS, Linux, macOS, Windows, and Web
- **Main entry point** is `lib/brick_lib.dart` which re-exports everything and defines the `HexColor` extension

## SDK Requirements

- Dart >=3.0.0 <4.0.0
- Flutter >=2.5.0