# Photo Gallery

Clever Rails + Hotwire coding challenge. See `../README.md` for the challenge spec.

## Requirements

- Ruby 3.3.5 (see `.ruby-version`)
- SQLite3
- Rails 8.1

## Setup

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

Then open <http://localhost:3000>.

## Tests

```bash
bin/rails test          # unit + integration
bin/rails test:system   # system tests
```

## Lint

```bash
bin/rubocop
```
