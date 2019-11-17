# TopDeskClient

## v0.2.4

### Features

- **Add support for Helper Functions**
  - Get-Category
  - Get-CallType
  - Get-ClosureCode
  - Get-EntryType
  - Get-Impact
  - Get-Priority
  - Get-ProcessingStatus
  - Get-SubCategory
  - New-OptionalField
- **Add date converter**
  - Date/Time objects are converted to ISO8601format
- **Add support for creating a basic incident**
  - Much smaller parameter set for convenience, uses New-Incident
  - Added support for linking basic incident to Major Incident
  - Added several parameter lookups by name as made available in TopDesk API

### Fixes

- Error when using Get-BlankAsset #14
- Saved connections not loading #15
- Fields parameter not handled properly for Get-Incident #22
- Get-Incident by Number fails #24
- Connect-TopDesk not failing with incorrect URL #43
