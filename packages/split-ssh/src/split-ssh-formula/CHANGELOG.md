# Changelog

All notable changes will be documented in this file.

The format is based on [Keep a changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2023-09-28

## Changed

- The formula no longer creates _qubes_, instead it expects existing qubes to have a specific set to QVM tags. See README for usage instructions. (Qubes that were created by a previous version of this tool can be tagged retroactively.)

## Fixed

- Different Split-SSH _clients_ can no have different Split-SSH _backends_. It was a known limitation of v1.0.0 that all clients would be configured to use whichever backend was defined first.

## [1.0.0] - 2023-09-05

## Added

- No changes, only a clean version number before releasing breaking changes.

## [0.2.2] - 2021-03-01

### Fixed

- Fix syntax error in pillar access from SLS templates

## [0.2.1] - 2021-03-01

### Fixed

- Fix missing vault information in clients
- Fix syntax error in pillar access from SLS templates

## [0.2.0] - 2021-02-28

### Added

- Allow state to be configured via Salt pillar

## [0.1.0] - 2021-02-14

### Added

- Initial release
- A proof-of-concept split-SSH state.

  [0.1.0]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/releases/tag/qubes-mgmt-salt-user-split-ssh-0.1.0-1
  [0.2.0]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/releases/tag/qubes-mgmt-salt-user-split-ssh-0.2.0-1
  [0.2.1]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/releases/tag/qubes-mgmt-salt-user-split-ssh-0.2.1-1
  [0.2.2]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/releases/tag/qubes-mgmt-salt-user-split-ssh-0.2.2-1
  [1.0.0]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/releases/tag/qubes-mgmt-salt-user-split-ssh-1.0.0-1
