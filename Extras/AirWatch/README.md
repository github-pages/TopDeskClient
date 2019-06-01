# Get-AWiPads.ps1

Get-AWiPads is used to dump the list of devices from AirWatch into a csv file. This csv file can then be uploaded to TopDesk for automated updates to assets.

## Pre-Requisites

- Enable API access in AirWatch tenant
- Setup account to be used to access the AirWatch API 

[AirWatch REST APIs 101](https://blogs.vmware.com/euc/2017/05/vmware-airwatch-101-airwatch-rest-apis.html)

[AirWatch REST API Guide](https://resources.workspaceone.com/view/zv5cgwjrcv972rd6fmml/en)

Access API documentation from your tenant using https://{apiURL}/api/help

## Initial Setup

- Schedule Get-AWiPads.ps1 to run on desired schedule and create an updated export of AirWatch Devices.
