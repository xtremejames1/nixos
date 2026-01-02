# Fix for dfu-programmer compilation with GCC 14.3.0+
#
# Problem: dfu-programmer 0.7.2 uses 'false' and 'true' as custom enum constants
# in dfu-bool.h. Starting with GCC 14 (C23 standard), these are reserved keywords,
# causing compilation to fail.
#
# Solution: Force compilation with C17 standard where false/true are not keywords.
# Also need to define _DEFAULT_SOURCE to expose strcasecmp/strncasecmp functions,
# and allow implicit function declarations since the code doesn't include <strings.h>.
#
# Related: dfu-programmer is a dependency of QMK (quantum mechanical keyboard tools)
# Can be removed when dfu-programmer is updated or removed from dependencies.

final: prev: {
  dfu-programmer = prev.dfu-programmer.overrideAttrs (oldAttrs: {
    # Set CFLAGS environment variable to force C17 standard and enable compatibility
    # -std=c17: Use C17 standard (false/true not keywords)
    # -D_DEFAULT_SOURCE: Enable POSIX and BSD functions like strcasecmp
    # -Wno-error=implicit-function-declaration: Downgrade implicit declaration errors to warnings
    CFLAGS = "-std=c17 -D_DEFAULT_SOURCE -Wno-error=implicit-function-declaration";
  });
}
