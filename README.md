# Q365-Implementation

An implementation of the [Q!365 Package](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000E2LKdUAN). Contains invocable methods to more easily interact with the Microsoft Graph API.

## Deploy

<a href="https://github.com/Enclude-Components/Q365-Implementation/releases/latest">
  <img alt="Install Latest Release"
       src="https://img.shields.io/badge/Install%20Latest%20Release-238636?style=for-the-badge&logoColor=white&logo=DocuSign">
</a>

## Contents

- Apex Classes
    - SharepointCreateFolderInvocable.cls
    - SharepointCreateRecordLinkInvocable.cls
    - SharepointSearchFolderInvocable.cls
    - Sharepoint.cls
- Custom Settings
    - Sharepoint_Settings__c

## Development

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `cci org browser dev` to open the org in your browser.

## Release

1. Release a Beta Version
```bash
cci flow run release_unlocked_beta --org dev
```

2. Test Deploy the Beta Version
```bash
cci flow run ci_beta --org beta
```

3. Promote to a Production Version
```bash
cci flow run release_unlocked_production --org release
```