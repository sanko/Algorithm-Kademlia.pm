# Changelog

All notable changes to Algorithm::Kademlia will be documented in this file.

## [Unreleased]

### Added

- `Algorithm::Kademlia::Storage::Entry` to hold stored data including seeds and leechers.
- `Algorithm::Kademlia::RoutingTable->import_peers()` method for bulk-loading peers into buckets.

### Changed

- `Algorithm::Kademlia::RoutingTable->local_id_bin` now has reader and writer accessors.
- Requires perl v5.42.x

[v1.0.0] - 01-25-2016

### Added

- Pulled out of Net::BitTorrent::DHT for use in other DHTs.
