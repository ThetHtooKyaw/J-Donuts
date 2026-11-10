# J'Donuts

A Flutter app for the J'Donuts brand: onboarding and phone-OTP auth, a home feed of
seasonal/popular/previous products and nearby shops, a rewards screen with tier and
points progress, and a product detail screen with a quantity stepper.

Everything runs **fully offline** against a local Drift (SQLite) database and a fake
auth layer. There is no backend, no API key, and no network call.

---

## 1. How to run it

**Requirements:** Flutter 3.47.x (stable) with Dart 3.13.x, plus either an iOS
simulator, an Android emulator, or a physical device.

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate the Drift database code
#    (only needed if you change a table definition in drift_database.dart)
dart run build_runner build --delete-conflicting-outputs

# 3. Run it
flutter run                 # pick a connected device when prompted
flutter run -d <device-id>  # or target one explicitly
```

Other useful commands:

```bash
flutter analyze     # currently 0 errors, 0 warnings, 19 deprecation infos
flutter test        # NOTE: the default widget_test.dart fails, see Known gaps
flutter clean       # if you hit odd build or codegen issues
```

**If the app opens to a blank/error screen after you change a table or a seed value**,
delete the app from the simulator/emulator and reinstall. Drift keeps its database in
the app's documents directory (`j_donuts.sqlite`), and seed data only runs on a fresh
create or a schema upgrade.

**Platforms:** only `android/` and `ios/` are included (Windows/Linux/macOS/web were
removed). Android app id / namespace: `com.example.j_donuts`. The app was developed and
run against an Android target.

---

## 2. Flutter and Dart versions

|                                 | Version                                                          |
| ------------------------------- | ---------------------------------------------------------------- |
| Flutter                         | 3.47.9 (stable, engine `9e025265be`)                             |
| Dart                            | 3.13.7                                                           |
| SDK constraint (`pubspec.yaml`) | `^3.10.7`                                                        |
| Material                        | Material 3 (`useMaterial3: true`)                                |
| Android                         | `minSdk`/`targetSdk` = Flutter defaults, Kotlin DSL Gradle files |

Key packages: `flutter_bloc ^9.1.1`, `go_router ^17.5.0`, `drift ^2.35.4`
(+ `drift_dev ^2.35.3`, `build_runner ^2.17.1`), `get_it ^9.3.0`,
`flutter_secure_storage ^11.2.0`, `google_fonts ^8.2.1`, `intl ^0.20.2`.
`sqlite3_flutter_libs` is pinned to `^0.6.0+eol`.

---

## 3. Architecture

The project uses **Clean Architecture, sliced by feature**. Each feature under
`lib/features/` is split into three layers, and dependencies only point inwards
(presentation → domain ← data). Domain never imports Drift, Flutter, or anything in
`data/`.

```
Presentation (screens, widgets, cubits)
        ↓ calls
Domain (entities, repository interfaces, use cases, validators)
        ↑ implemented by
Data (repositories, local data sources, Drift rows, models)
```

- **Domain** holds pure Dart: entities (`Product`, `Shop`, `MemberProfile`,
  `MemberRewardsInfo`, `User`), abstract repository contracts, one class per use case,
  and validators.
- **Data** implements the repository contracts. The repositories are the _mappers_:
  they translate Drift row types (`MemberTableData`, `ProductsTableData`, …) into domain
  entities, so Drift types never leak into the UI.
- **Presentation** is BLoC/Cubit + widgets. Screens read state via `BlocBuilder` and
  dispatch intents via `context.read<...Cubit>()`.
- **Core** holds cross-feature pieces: theming, routing, the service locator, and
  shared widgets.

**Composition root:** `lib/core/services/locator.dart` registers everything with GetIt
(`setupLocator()` is awaited in `main()` before `runApp`). Data sources, repositories
and use cases are `LazySingleton`s; `HomeCubit` and `RewardsCubit` are `Factory`s so each
screen gets a fresh instance; `AuthCubit` is a `LazySingleton` so one state machine
drives the whole auth flow. `RewardsLocalDataSourceImpl` receives the **same**
`AppDatabase` singleton as the home feature — this is the seam that lets rewards read
the member table.

**Navigation** is `go_router`. Auth screens are plain top-level routes
(`/onboarding` → `/phone_input` → `/verify_otp` → `/name_input` → `/dob_input` →
`/welcome`). The logged-in shell is a `StatefulShellRoute.indexedStack` with three
branches (`/home`, `/rewards`, `/settings`) and a persistent custom bottom bar that
keeps each tab's state alive. The start route is chosen at launch from the stored
session (`/home` if logged in, otherwise `/onboarding`).

---

## 4. Folder map

```
lib/
├── main.dart                     # bootstrap: setupLocator → read session → MyApp
├── core/
│   ├── router/app_router.dart    # GoRouter config, auth + StatefulShellRoute
│   ├── services/locator.dart     # GetIt: DB, data sources, repos, use cases, cubits
│   ├── theme/
│   │   ├── app_colors.dart       # brand palette (teal, pink, orange, neutrals)
│   │   └── app_theme.dart        # M3 theme, Quicksand/Fredoka typography, button styles
│   └── widgets/
│       ├── app_bottom_nav_bar.dart  # custom nav bar w/ animated selected pill
│       ├── app_snack_bar.dart       # coming-soon + error snack bars
│       ├── noti_container.dart      # notification badge
│       └── primary_button.dart      # CTA button with inline loading spinner
│
└── features/
    ├── auth/
    │   ├── domain/               # User, AuthRepository, 7 use cases, AuthValidators
    │   ├── data/                 # secure-storage data source, UserModel, repo impl
    │   └── presentation/
    │       ├── cubit/            # AuthCubit + AuthState (AuthStep enum)
    │       ├── screens/          # onboarding, phone, verify OTP, name, DOB, welcome
    │       └── widgets/          # AuthScaffold, AuthTextfield, TermsAndPrivacy
    │
    ├── home/
    │   ├── domain/               # Product, Shop, MemberProfile, HomeRepository, use case
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   ├── drift_database.dart        # tables, migrations, seed data, queries
    │   │   │   ├── drift_database.drift.dart  # generated (do not edit)
    │   │   │   └── home_local_data_source.dart
    │   │   ├── models/product_model.dart
    │   │   └── repositories/home_repository_impl.dart
    │   └── presentation/
    │       ├── cubit/            # HomeCubit + HomeState
    │       ├── screens/          # home, product detail, settings
    │       └── widgets/          # CustomListview, ShopCard, skeletons, pill, headers
    │
    └── reward/
        ├── domain/               # MemberRewardsInfo, Voucher, RedemptionHistory, use cases
        ├── data/
        │   ├── datasources/rewards_local_data_source.dart   # reads member/vouchers/redemptions
        │   └── repositories/rewards_repository_impl.dart
        └── presentation/
            ├── cubit/            # RewardsCubit + RewardsState
            ├── screens/reward_screen.dart
            └── widgets/          # donut ring, donut fill, drink arc, tier tracker, quest card

assets/
├── images/   # banners, avatars, product art, donut/tier textures, shop photos
└── icons/    # google.png
```

---

## 5. State management: flutter_bloc (Cubit)

I used **Cubit** rather than full event-based BLoC. The screens have a single, clear
intent per user action (`verifyOtp`, `completeRegistration`, `logout`),
so named events would have added ceremony without adding clarity. Each feature owns a
Cubit and an immutable-ish state class with a hand-written `copyWith`.

| Cubit          | Scope                | Responsibilities                                                                     |
| -------------- | -------------------- | ------------------------------------------------------------------------------------ |
| `AuthCubit`    | app-wide singleton   | phone/OTP/name/DOB steps, 3-strike OTP lockout, login-vs-register branching, session |
| `HomeCubit`    | per screen (factory) | loads profile + 3 product categories + shops in one call                             |
| `RewardsCubit` | per screen (factory) | loads points/tier/vouchers/history, redeems a voucher and refreshes                  |

Screens use `BlocBuilder` for rendering and `BlocConsumer`/`listener` for one-off
navigation and snack bars, with `listenWhen` predicates so listeners only fire on real
transitions. Loading and error states are explicit fields on the state
(`isLoading`, `errorMessage`, `successMessage`), which is what the reward screen's
`errorMessage != null && rewardsInfo == null` branch is reading.

A few deliberate presentation choices that live in state rather than the widget:
`AuthState.progressPercentage` maps `AuthStep` → ring value (0.25/0.5/0.75/1.0), and
`failedOtpAttempts` drives both the read-only lockout of the OTP fields and the shake
animation trigger.

---

## 6. Offline strategy

There is no server, so "offline" here means **local-first by construction**:

- **Drift over SQLite** is the single source of truth for member, vouchers,
  redemptions, products and shops. `AppDatabase` is opened once as a singleton via
  `NativeDatabase.createInBackground` in the app documents directory.
- **Seed-on-create.** `MigrationStrategy.onCreate` creates the tables and seeds one
  member (`current_user`, "Hania", Bronze, 680,000 pts, 1,290 to next tier), two
  vouchers, nine products across `seasonal` / `popular` / `order_again`, and four shops.
  Migrations are versioned to `schemaVersion = 4` (v3 reseeded products/member/shops,
  v4 added `phoneNumber` + `dateOfBirth` to the member table).
- **Queries live behind a data source**, so the rest of the app never writes SQL by
  hand: `getMember()`, `getProductsByCategory()`, `getAllShops()`.
- **Rewards reads the same member row.** `RewardsLocalDataSourceImpl.getMemberProfile()`
  calls `database.getMember()` and the repository derives `totalPoints`, `tier`,
  `pointsToNextTier`, and per-voucher `isUnlocked` (`currentPoints >= pointsCost`) from
  it. No duplicated points state exists.
- **Redemption is one atomic transaction.** `deductPointsAndRedeem` checks the balance,
  decrements `memberTable.totalPoints`, and appends a `redemptionsTable` row inside
  `database.transaction(...)`, so points and history can never disagree. It throws on
  "member not found" / "insufficient points", which the Cubit surfaces as an error.
- **Auth state is cached separately** in `flutter_secure_storage`: one JSON blob for the
  registered user and a separate `ACTIVE_SESSION_KEY` flag. Launch reads the session to
  decide the start route; logout deletes only the session key so the profile survives
  for a later login.
- **Degradation is visible.** `HomeCubit` catches load failures and sets
  `errorMessage` + `isOffline`; `HomeState` still renders cached `data` when present,
  and per-section empty states (`SectionEmptyState`) cover categories with no rows.
- **`connectivity_plus` and `dio` are dependencies, but nothing calls them yet** — they
  are placeholders for a future remote sync (`HomeRepositoryImpl.refreshHomeData` is an
  intentional no-op stub).

---

## 7. Animations built

The motion is native Flutter (`AnimationController`, `AnimatedContainer`,
`CustomPaint`, `ClipPath`, shaders) — no animation packages.

1. **OTP shake on wrong code** (`verify_otp_screen.dart`) — a 400 ms
   `AnimationController` drives an `AnimatedBuilder` that wraps every digit box in
   `Transform.translate`. The horizontal offset alternates sign based on
   `floor(value * 8)` and decays with `(1 - value)`, so the row rattles and settles.
   It fires from the `BlocConsumer` listener when `errorMessage != null &&
failedOtpAttempts > 0`, simultaneously clearing all six boxes and refocusing the
   first field.
2. **OTP field auto-advance and backspace navigation** — a completed digit moves focus
   forward via a post-frame callback; `FocusNode.onKeyEvent` intercepts Backspace on an
   empty box to step back. A 5-minute countdown timer gated the Resend link.
3. **Donut ring progress with a texture mask** (`donut_ring_progress_widget.dart`) — a
   `CustomPainter` draws the points arc from `-π/2`, wrapped in a `ShaderMask` whose
   `ui.ImageShader` tiles `donut_texture.png` with `BlendMode.srcIn`, so the progress
   stroke is painted _with the donut texture_ over a translucent gray track. The center
   shows the live total (e.g. `680,000`) with thousands separators.
4. **Donut fill-by-slice** (`donut_progress_widget.dart`) — two stacked donut images,
   where a `CustomClipper<Path>` (`_RadialProgressClipper`) reveals the colored layer
   with an `arcTo` wedge sweeping clockwise from the top. At 100% it short-circuits to a
   full rect so the ring never shows antialiasing seams.
5. **Curved drink arc** (`drink_progress_widget.dart`) — a half-circle
   `CustomPainter` (180° start, 180° sweep) draws a track plus a proportional progress
   arc above the drink image.
6. **Tier tracker** (`tier_progress_widget.dart`) — vertical badge timeline where the
   current step renders 44 px at full opacity and future steps 36 px at 0.5; connector
   lines are `LinearProgressIndicator`s rotated 90°.
7. **Bottom nav selection** — `AnimatedContainer` (200 ms) grows the selected item's
   pill and reveals its text label; reward tab buttons use the same animated pill.
8. **Skeleton loading** (`home_skeletons.dart`) — a static layout-matching skeleton of
   the header, three product rows and the shops carousel, shown while `HomeCubit` loads.
   (Deliberately not shimmering; static boxes keep it cheap and calm.)
9. **Image fade-ins** — onboarding and welcome banners use a `ShaderMask` with a
   vertical `LinearGradient` (`BlendMode.dstIn`) to fade the artwork into the
   background, and the promo carousel uses `ClipRRect` + alignment cropping for a
   polished hand-off.

---

## 8. Fake OTP code

The auth backend is mocked in `AuthRepositoryImpl` with a 1-second artificial delay on
send, verify and register.

> **The OTP code is `123456`.**

Any other code fails. Three consecutive wrong codes lock the input
(`failedOtpAttempts >= 3`) and change the message to "Too many wrong attempts. Please
request a new code."; the user must wait for the 5:00 countdown and tap Resend, which
resets the attempts.

**Auth walkthrough:** tap _Let's get started_ → enter a phone in the local format
(`09254135592`; it is normalized to `9xxxxxxxxx`) → `123456` → first name (letters and
spaces, including Myanmar script) and optional last name → a valid DOB (at least 13
years old). Registration writes the user to secure storage and copies name/phone/DOB
into the Drift `memberTable` row. _Log in_ from the onboarding screen only succeeds for
the phone number already cached on the device; a different number prompts to create a
new account.

---

## 10. Time spent

Reconstructed from the git history (13 commits, two working sessions):

| Date (UTC+04:00)   | Work                                                                        |
| ------------------ | --------------------------------------------------------------------------- |
| Nov 8, 06:24–07:14 | Scaffold, dependencies, asset folders, trim to Android/iOS                  |
| Nov 8, 21:36       | Auth: phone + verify OTP screens, secure storage, validators                |
| Nov 9, 06:24–07:26 | Auth: onboarding, name, DOB, welcome; Home data + domain + repo             |
| Nov 9, 18:21       | Home feature (Drift DB, seed data, home screen, widgets)                    |
| Nov 9, 20:31–20:43 | Auth polish + OTP shake animation                                           |
| Nov 9, 22:10       | Product detail screen                                                       |
| Nov 10, 04:56      | Rewards feature (Drift-backed points, progress widgets, redeem transaction) |

**Estimated total: ~16–18 hours of hands-on build time** across roughly 2.5 calendar
days (first commit Nov 8 06:24 → last commit Nov 10 04:56 is ~46 hours elapsed, with
the bulk of coding concentrated in Nov 9–10). This estimate is derived from commit
timestamps and session clustering, not from a tracked timer — treat it as approximate.
