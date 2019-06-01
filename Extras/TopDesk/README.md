# TopDesk

Upload.ps1 provides a sample of uploading the CSV exports to TopDesk.

## Pre-Requisites

- Upload.ps1
  - Update $ExportRoot and $Exports to point to the path where exported CSV files are saved.
  - Replace "customer-name" in the url: 'https://customer-name.topdesk.net/services'
  - Replace "AAA..." with the base64 encoded credentials - 'Authorization' = 'Basic AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=='
- Run exports for each asset type to generate the CSV files

## Initial Setup

- In TopDesk, navigate to Settings > Import Settings > Asset Management Imports > Imports
  - Create a new import for each asset type that will be uploaded and select desired settings.
  - On the **Source** step, ensure that the selected file name matches what you have configured for exports.
  - On the Scheduling step, select Automated, preview and save.
