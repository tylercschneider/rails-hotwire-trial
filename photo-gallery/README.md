# Photo Gallery — Clever Rails + Hotwire Challenge

Submission for the [Clever Rails + Hotwire coding challenge](../README.md). Authenticated photo gallery with Hotwire-powered likes, server-rendered, no SPA framework.

## Quick start

```bash
cd photo-gallery
bundle install
bin/rails db:prepare      # creates DB, migrates, seeds (4 users + 14 photos + sample likes)
bin/rails server
```

Open <http://localhost:3000>. Sign in using one of the demo accounts below.

**Requirements:** Ruby 3.3.5 (`.ruby-version`), Rails 8.1, SQLite 3, ImageMagick (only if regenerating the project images).

## Demo accounts

All accounts use the password `password`. The sign-in page shows one-click buttons for each:

| Email                  | Role / sample state                            |
| ---------------------- | ---------------------------------------------- |
| `admin@example.com`    | Admin, no pre-liked photos                     |
| `alice@example.com`    | Viewer, has liked the first 2 photos           |
| `bob@example.com`      | Viewer, has liked the first 3 photos           |
| `carol@example.com`    | Viewer, has liked the first 4 photos           |

## What's in the gallery

- 10 Pexels photos seeded from `db/photos.csv`
- 4 project cards (Event Engine, Tile Takeoff, Tyler Schneider, SOTA Building) self-hosted under `public/projects/`
- Any photo a signed-in user adds via **Add photo** in the nav

## Features

| Area | Notes |
|---|---|
| **Auth** | Rails 8 generator (`User`, `Session`, `Current` + `Authentication` concern on `ApplicationController`); `has_secure_password` with bcrypt |
| **Likes** | `Like belongs_to :user, :photo`; unique compound index on `(user_id, photo_id)` and matching app-level validation |
| **Hotwire** | Like button submits via `button_to` inside a `turbo_frame_tag`; controller renders the `_like` partial, Turbo swaps that frame in place — no full reload |
| **Stimulus** | `like_controller` flips the star optimistically; `mobile_nav_controller` powers the hamburger toggle on mobile |
| **Add / edit / delete** | Signed-in users can add a photo (URL-based, not file upload); only the uploader sees Edit / Delete buttons on their own cards |
| **Caching** | `photos.likes_count` counter cache (no per-card COUNT) + a single `pluck` for the current user's liked photo IDs (no per-card EXISTS) + fragment cache keyed on `[photo, Current.user]` |
| **Responsive** | Mobile-first CSS; grid reflows 1 → 2 → 3 columns at 640 / 1024 px; nav collapses behind a hamburger below 640 px |
| **Tests** | Minitest unit + integration: validations, uniqueness, seed counts, controller flows for sign-in, photos CRUD with uploader scoping, likes create/destroy + idempotency |

## Tests + lint

```bash
bin/rails test          # 33 runs, 82 assertions
bin/rubocop             # omakase config
bin/brakeman            # security scan
bin/bundler-audit       # dependency audit
```

CI runs all of the above plus `bin/rails test:system` on every PR. The workflow lives at `../.github/workflows/ci.yml` (repo root, with `working-directory: photo-gallery`).

## Project layout

```
photo-gallery/
├── app/
│   ├── controllers/                sessions, photos, likes, passwords
│   ├── models/                     User, Session, Current, Photo, Like
│   ├── views/photos/               index, new, edit, _photo, _form, _like
│   ├── javascript/controllers/     like_controller, mobile_nav_controller
│   └── assets/stylesheets/         application.css (mobile-first, no framework)
├── config/
│   ├── routes.rb                   photos do resource :like end ; sessions ; passwords
│   └── storage.yml                 Disk service
├── db/
│   ├── photos.csv                  Seed data
│   ├── seeds.rb                    Idempotent user + photo + sample-like seeding
│   └── schema.rb
├── public/projects/                Self-hosted project screenshots (EXIF stripped)
└── test/                           Minitest
```

## Notes for reviewers

- The CI workflow at the **repo root** (`.github/workflows/ci.yml`) is what GitHub actually runs — the Rails scaffold puts one inside `photo-gallery/.github/` which GH ignores, so it was moved.
- I went URL-only for user-submitted photos (`Photo#src_medium` is a URL or path string). Active Storage would be a natural next step.
- Email delivery for the password-reset flow isn't configured (no SMTP), so the **Forgot password?** link is hidden from sign-in.
- The Rails 8 scaffold ships `allow_browser versions: :modern` in `ApplicationController` — that was removed because it 406'd older mobile UAs (including DevTools' iPhone emulation in Firefox).
