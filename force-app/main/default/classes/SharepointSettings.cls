// Extend the CustomSettings class
public inherited sharing class SharepointSettings extends CustomSettings {
    // Override the getInstance method to return your own setting's instance
    public override SObject getInstance(Id userId) {
        return Sharepoint_Settings__c.getInstance(userId);
    }
}