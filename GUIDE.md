# Developer Guide

This guide covers how to set the project up, how the screens/data fit
together, and the rough edges a new contributor should know about before
touching the code.

## 1. Setup

1. Install Flutter (see "SDK version note" below before picking a version).
2. Clone the repo and fetch packages:
   ```bash
   git clone https://github.com/Natnael3344/Banking.git
   cd Banking
   flutter pub get
   ```
3. Run on a connected device/emulator/simulator:
   ```bash
   flutter run
   ```

There is no `.env`, no API keys, no backend URL, and no build configuration
beyond the standard Flutter/Android/iOS platform folders (`android/`,
`ios/`) — the app is entirely self-contained.

### SDK version note (important)

`pubspec.yaml` declares:

```yaml
environment:
  sdk: ">=2.7.0 <3.0.0"
```

That is a pre-null-safety Dart constraint, and the UI code uses
`RaisedButton` and `FlatButton` (in `lib/main.dart`, `lib/Customers.dart`,
and `lib/Transfer.dart`), both of which are deprecated and were removed in
later Flutter releases in favor of `ElevatedButton`/`TextButton`. In
practice this means:

- Running `flutter run`/`flutter pub get` with a **current** Flutter SDK
  will likely fail or require raising the SDK constraint and replacing the
  deprecated button widgets.
- To run the project exactly as committed, use an older Flutter SDK from
  around the Dart 2.7–2.9 era (pre-null-safety), or install
  [Flutter Version Management (FVM)](https://fvm.app/) to pin a compatible
  version alongside your primary Flutter install.
- To modernize it, bump the `sdk` constraint, migrate the code to null
  safety, and swap `RaisedButton`/`FlatButton` for `ElevatedButton`/
  `TextButton`.

This is the single biggest thing to sort out before doing any other work on
the app.

## 2. How the pieces fit together

The app has no state management library, no backend, and no persistence —
everything lives in one static, in-memory data source and four screens that
all read/write that same source directly.

### Data model (`lib/CustomersList.dart`)

Three parallel top-level lists act as the entire "database":

```dart
List<String> name = <String>[...];    // 10 names
List<String> email = <String>[...];   // 10 emails (index-aligned with name)
List<dynamic> balance = <dynamic>[...]; // 11 balances (note: one more than name/email — see below)
```

A "customer" is really just an index `i` into `name[i]` / `email[i]` /
`balance[i]`. There is no `Customer` class/model — screens pass the three
raw fields around individually.

**Known data bug**: `balance` has 11 entries while `name` and `email` have
10. Any code path that legitimately reaches index 10 (e.g. iterating the
full `balance` list) would go out of bounds against `name`/`email`. The
existing screens only iterate indices 0–9, so this isn't hit in practice,
but it's worth fixing or at least being aware of if you extend the customer
list.

### Screen flow

```
main.dart (MyApp / MyHome)
  -> "Start" button -> Customers.dart
       -> tap a customer tile -> Individual.dart (read-only detail view)
       -> "Transfer" button (AppBar action) -> Transfer.dart
```

- **`main.dart`** — `MyApp` is the `MaterialApp` root; `MyHome` is the
  landing screen with the background image and the "Start" floating action
  button that navigates to `Customers`.
- **`Customers.dart`** — Builds a `ListView` of 10 tiles from the
  `name`/`email`/`balance` lists via a local `Tile()` helper. Each tile
  navigates to `Individual`, passing that customer's `name`/`email`/
  `balance` as constructor arguments (note the parameters are spelled
  `namE`, `emaiL`, `balancE` — an odd but real naming choice in the code).
  The AppBar has a "Transfer" action that opens `Transfer`.
- **`Individual.dart`** — Stateless detail screen; purely displays the
  three values passed in. Makes no further data lookups.
- **`Transfer.dart`** — Stateful screen holding an `initial` amount
  (adjustable with +/- `IconButton`s or by typing a number into a
  `TextFormField` and pressing "Set"). Below that, it lists all 10
  customers again; tapping one shows a confirmation dialog, and confirming
  ("Ok" then "Done") runs:
  ```dart
  balance[number] = balance[number] + initial;
  ```
  This **adds** the chosen amount to the selected recipient's balance in
  the shared in-memory list. There is no sender account being debited —
  it's a one-way balance bump, not a true A-to-B transfer. Because
  `balance` is a top-level mutable list, this mutation is visible from any
  screen that re-reads it, but changes are lost on app restart (no storage
  layer of any kind).

## 3. Things a new contributor should know

- **No API layer**: there are no HTTP calls, REST endpoints, or backend
  services anywhere in the code — everything is local widget state plus the
  static lists above. If you're looking for `API_REFERENCE.md`, it doesn't
  exist in this repo for that reason.
- **No tests that exercise this app**: `test/widget_test.dart` is the
  default counter-app smoke test that `flutter create` generates, unmodified.
  It calls `find.byIcon(Icons.add)`, which does not exist in this app's UI,
  so running `flutter test` will fail. Anyone adding real tests should
  replace this file with widget tests that pump `Customers`, `Individual`,
  or `Transfer` directly.
- **No input validation**: `Transfer`'s amount field calls
  `int.parse(value)` directly in `onChanged`; entering a non-numeric string
  will throw at runtime (no try/catch).
- **Assets**: the only non-code asset is `images/blue.png`, declared under
  `flutter: assets:` in `pubspec.yaml` as the whole `images/` directory.
- **Platform folders**: `android/` and `ios/` are standard, largely
  unmodified `flutter create` output — the only real customization to look
  for there is the app id/bundle id and app icon, not app logic.
- **Single upstream commit**: at the time of writing, the project history
  is a single commit ("Simple Banking App"), so there's no prior design
  discussion or changelog to consult beyond the code itself.
