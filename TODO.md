# TODO

## Sound Effects

- [x] Add paddle-hit sound effect and trigger on `Ball:handlePaddleCollision(...)`.
- [x] Add wall-bounce sound effect and trigger on top/bottom boundary bounce.
- [x] Add score sound effect (to be wired when scoring is implemented).
- [ ] Add audio settings in config (master volume, SFX volume, mute toggle).

## Fonts

- [x] Choose and add title font asset.
- [x] Choose and add score font asset.
- [x] Load fonts in `love.load()` and apply distinct fonts for title vs score.
- [x] Add font config entries (asset path and size).
- [ ] Add safe fallback to default Love2D font if custom font load fails.

## Gameplay UX

- [ ] Add warning/confirmation prompts when pressing reset or escape during an active game.
