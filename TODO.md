# TODO

## Sound Effects
- [ ] Add paddle-hit sound effect and trigger on `Ball:handlePaddleCollision(...)`.
- [ ] Add wall-bounce sound effect and trigger on top/bottom boundary bounce.
- [ ] Add score sound effect (to be wired when scoring is implemented).
- [ ] Add audio settings in config (master volume, SFX volume, mute toggle).

## Fonts
- [ ] Choose and add title font asset.
- [ ] Choose and add score font asset.
- [ ] Load fonts in `love.load()` and apply distinct fonts for title vs score.
- [ ] Add font config entries (asset path and size).
- [ ] Add safe fallback to default Love2D font if custom font load fails.
