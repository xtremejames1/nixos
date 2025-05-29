{ pkgs, ...}:
{
  # This is configured for Thinkpad P14s Gen 4
  # To enroll, run sudo fprintd-enroll -f right-little-finger $USER
  # the fingers are as follows, left/right-thumb/little-finger/ring-finger/middle-finger/index-finger
  # To delete, run fprintd-delete -f $finger $USER
  # To verify, run fprintd-verify -f #finger $USER
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
}
