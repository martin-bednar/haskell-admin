# haskell-admin-health

_A server component for [Haskell Admin](https://github.com/martin-bednar/haskell-admin)_

This components reports application health.
Currently, its only endpoint is `/status`, which yields the current health status of the application (Running / Finished / Error).

Desired future features:

- Recover from an error (e. g. by restarting the application)
- Forcibly stop the application