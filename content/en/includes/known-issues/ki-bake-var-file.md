#### Bake failures

The Packer version included with Rosco disregards package overrides that use the `-var-file=` option. This may cause bakes to fail.

**Affected versions**: 2.22.2 and later, 2.23.3 and later, 2.24.x, and 2.25.x