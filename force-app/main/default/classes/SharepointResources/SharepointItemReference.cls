@IsTest
@SuppressWarnings('PMD.AvoidGlobalModifier')
global class SharepointItemReference {
    @AuraEnabled
    global String driveId;
    @AuraEnabled
    global String id;
    @AuraEnabled
    global String path;
    @AuraEnabled
    global SharePointIds sharepointIds;
}