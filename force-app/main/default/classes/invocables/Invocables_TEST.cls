@IsTest
@SuppressWarnings('PMD.MethodNamingConventions')
private class Invocables_TEST {
    @IsTest
    static void createFolderInvocable() {
        // Arrange
        SharepointCreateFolderInvocable.Params param = new SharepointCreateFolderInvocable.Params();
        param.name = 'Test Folder';
        SharepointDriveItem resBody = new SharepointDriveItem();
        resBody.id = 'Test-Id';
        
        // Act
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(200, JSON.serialize(resBody));
        SharepointCreateFolderInvocable.Output[] outputs = SharepointCreateFolderInvocable.invoke(
            new List<SharepointCreateFolderInvocable.Params> {
                param
            }
        );
        Test.stopTest();
        
        // Assert
        Assert.areEqual(1, outputs.size(), 'Unexpected output size');
        Assert.areEqual('Test-Id', outputs.get(0).item.id, 'Folder ID should match');
    }
    @IsTest
    static void createRecordLinkInvocable() {
        // Arrange
        SharepointCreateRecordLinkInvocable.Params param = new SharepointCreateRecordLinkInvocable.Params();
        param.recordId = '003AP00000Xow93YAB'; //NOPMD
        param.item = new SharepointDriveItem();
        param.item.name = 'Test Item';
        
        // Act
        Test.startTest();
        SharepointCreateRecordLinkInvocable.Output[] outputs = SharepointCreateRecordLinkInvocable.invoke(
            new List<SharepointCreateRecordLinkInvocable.Params> {
                param
            }
        );
        Test.stopTest();
        
        // Assert
        Assert.areEqual(
            1,
            [SELECT Id FROM qkom365__O365_Metadata__c WHERE qkom365__RelatedToId__c = '003AP00000Xow93YAB'].size(),
            'Unexpected number of records created'
        );
    }
    @IsTest
    static void searchFolderInvocable() {
        // Arrange
        SharepointSearchFolderInvocable.Params param = new SharepointSearchFolderInvocable.Params();
        param.query = 'Test Query';

        SharepointSearchResponse mockRes = new SharepointSearchResponse();
        SharepointDriveItem mockItem = new SharepointDriveItem();
        mockItem.id = 'Test-Id';
        mockRes.value = new List<SharepointDriveItem> {
            mockItem
        };
        
        // Act
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(200, JSON.serialize(mockRes));
        SharepointSearchFolderInvocable.Output[] outputs = SharepointSearchFolderInvocable.invoke(
            new List<SharepointSearchFolderInvocable.Params> {
                param
            }
        );
        Test.stopTest();
        
        // Assert
        Assert.areEqual(1, outputs.size(), 'Unexpected output size');
        Assert.areEqual(1, outputs.get(0).results.size(), 'Unexpected results size');
        Assert.areEqual('Test-Id', outputs.get(0).results.get(0).id, 'Folder ID should match');
    }
}