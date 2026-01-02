# Central overlay aggregator for custom package modifications
# Each overlay is imported from a separate file for better organization

final: prev:
  # Compose multiple overlays by merging their attribute sets
  (import ./dfu-programmer-fix.nix final prev)
  # Future overlays can be added here:
  # // (import ./another-overlay.nix final prev)
  # // (import ./yet-another-overlay.nix final prev)
