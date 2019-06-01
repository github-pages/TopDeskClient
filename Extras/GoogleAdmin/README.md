# Chromebook Sync

ChromeBook_Sync.exe is used to dump the list of devices from your Google admin directory into a csv file. This csv file can then be uploaded to TopDesk for automated updates to Chromebook assets.

## Pre-Requisites

- Enable API access in the Admin console [G Suite Admin Help](https://support.google.com/a/answer/60757)
- Admin Directory API Client Library for .NET\* These files are included in the GoogleAdmin directory where this README.md lives. [.Net API Client](https://developers.google.com/api-client-library/dotnet/apis/admin/directory_v1)
- client_secret.json is generated when setting API access for the user account that will execute the sync - *note this directory includes an empty client_secrets.json to demonstrate the file name & location. This file must be replaced with the client_secrets.json file you download from Google Admin.

## Initial Setup

- On the system that will be running the sync, login using the account you configured for API access in Google Admin. *It is required that you have an interactive session to authenticate and recieve authentication token. This process will have to be repeated periodically to renew the authentication token.*
- From a command prompt, change to the GoogleSync directory.

```CMD
        C:\>CD C:\GoogleSync
```

- Execute ChromeBook_Sync.exe \<CustomerID\> \<FullPathtoCSV\>.  *In the following example we use a customer number ~~C00100100~~, replace this value with your customer number.*

```CMD
        C:\GoogleSync>ChromeBook_Sync.exe C00100100 C:\MyChromebooks\Chromebooks.csv
```

- You will be prompted to login to Google. Once authenticated, your account will recive a token from Google that will be used for scheduled runs using this account.
- Create a scheduled task to run as the account with API access, have it execute ChromeBook_Sync.exe on the desired schedule.
- This should be tested and the task monitored for token expiry.

*When run interactively, the process will output incremental numbers representing calls to retrieve ChromeBooks. Verify the results by opening the created/updated CSV file and examine the contents.*
