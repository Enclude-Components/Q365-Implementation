@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class Sharepoint {
    private static final SharepointSettings SHAREPOINT_SETTINGS = new SharepointSettings();
    
    global static SharepointDriveItem createFolder(String name) {
        String basePath = getBasePath();
        Map<String, Object> body = new Map<String, Object> {
            'name' => normalize(name),
            '@microsoft.graph.conflictBehavior' => 'rename',
            'folder' => new Map<String, Object>()
        };
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(body));

        HttpResponse res = QKomGraphUtils.send(
            req,
            basePath + '/children'
        );
        if (res.getStatusCode() > 299) {
            throw new SharepointException(res.getStatusCode() + ': ' + res.getBody());
        }
        return (SharepointDriveItem)JSON.deserialize(res.getBody(), SharepointDriveItem.class);
    }
    global static SharepointSearchResponse searchFolder(String query) {
        String basePath = getBasePath();
        query = EncodingUtil.urlEncode(query, 'UTF-8');
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        HttpResponse res = QKomGraphUtils.send(
            req,
            basePath + '/search(q=\'' + query + '\')?$top=5'
        );
        if (res.getStatusCode() > 299) {
            throw new SharepointException(res.getStatusCode() + ': ' + res.getBody());
        }
        return (SharepointSearchResponse)JSON.deserialize(res.getBody(), SharepointSearchResponse.class);
    }
    global static qkom365__O365_Metadata__c createRecordLink(Id recordId, SharepointDriveItem item) {
        qkom365__O365_Metadata__c mdt = new qkom365__O365_Metadata__c(
            qkom365__RelatedToId__c = recordId,
            qkom365__Document_Name__c = item.name,
            qkom365__O365_WebUrl__c = item.webUrl,
            qkom365__O365Id__c = item.id,
            qkom365__O365DriveId__c = item.parentReference?.driveId,
            qkom365__O365SiteId__c = item.parentReference?.sharepointIds?.siteId,
            qkom365__O365ParentId__c = item.parentReference?.id,
            qkom365__O365Type__c = String.isBlank(item.file?.mimeType)
                ? 'Folder'
                : 'File'
        );
        insert as user mdt;
        return mdt;
    }
    @TestVisible
    private static String normalize(String path) {
        path = path.replace('"','').replace(';','').replace(':','').replace('*','').replace('<','').replace('>','').replace('?','').replace('/','-').replace('\\','-').replace('|','-');
        return path.removeEnd('.');
    }
    private static String getBasePath() {
        String basePath = (String)SHAREPOINT_SETTINGS.get('Root_Drive__c');
        if (String.isBlank(basePath)) {
            throw new SharepointException('SharepointSetting Root_Drive__c must be set in Custom Settings');
        }
        return basePath.removeEnd('/');
    }
    global class SharepointException extends Exception {}
}