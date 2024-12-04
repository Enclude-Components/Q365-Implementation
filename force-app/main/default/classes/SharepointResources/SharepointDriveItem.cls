@IsTest
@SuppressWarnings('PMD.AvoidGlobalModifier')
global class SharepointDriveItem {
    @AuraEnabled
    global Datetime createdDateTime;
    @AuraEnabled
    global String eTag;
    @AuraEnabled
    global String id;
    @AuraEnabled
    global String name;
    @AuraEnabled
    global String webUrl;
    @AuraEnabled
    global SharepointItemReference parentReference;
    @AuraEnabled
    global SharepointFile file;
    @AuraEnabled
    global SharepointFolder folder;
}