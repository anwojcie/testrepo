# Current preview release

## [2.0-preview.6] - 2020-08-17

### Breaking Changes

- Rename `-FromUnixTime` to `-UnixTimeSeconds` on `Get-Date` to allow Unix time input (#13084) (Thanks @aetos382!)
- Make `$ErrorActionPreference` not affect `stderr` output of native commands (#13361)
- Allow explicitly specified named parameter to supersede the same one from hashtable splatting (#13162)

### Engine Updates and Fixes

- Refactor command line parser to do early parsing (#11482) (Thanks @iSazonov!)
- Add support for some .NET intrinsic type converters (#12580) (Thanks @iSazonov!)
- Refresh and enable the `ComInterop` code in PowerShell (#13304)
