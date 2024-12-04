@IsTest
@SuppressWarnings('PMD.MethodNamingConventions')
private class Sharepoint_TEST {
    @IsTest
    static void testCreateFolder_Success() {
        // Arrange
        String folderName = 'Test Folder';
        String mockResponse = '{"id": "123", "name": "Test Folder", "webUrl": "https://test.sharepoint.com/folder", ' +
            '"parentReference": {"driveId": "testDriveId", "id": "parentId", "sharepointIds": {"siteId": "testSiteId"}}}';
        
        // Act
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(200, mockResponse);
        SharepointDriveItem result = Sharepoint.createFolder(folderName);
        Test.stopTest();
        
        // Assert
        Assert.areEqual('Test Folder', result.name, 'Folder name should match');
        Assert.areEqual('123', result.id, 'Folder ID should match');
        Assert.areEqual('testDriveId', result.parentReference.driveId, 'Drive ID should match');
    }
    
    @IsTest
    static void testCreateFolder_Error() {
        
        // Act & Assert
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(400, 'Bad Request');
        try {
            Sharepoint.createFolder('Test Folder');
            Assert.fail('Should have thrown an exception');
        } catch(Sharepoint.SharepointException e) {
            Assert.isTrue(e.getMessage().contains('400'), 'Error message should contain status code');
        }
        Test.stopTest();
    }
    
    @IsTest
    static void testSearchFolder_Success() {
        // Arrange
        String query = 'test query';
        String mockResponse = '{"value": [{"id": "123", "name": "Test File", "webUrl": "https://test.sharepoint.com/file"}]}';
        
        // Act
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(200, mockResponse);
        SharepointSearchResponse result = Sharepoint.searchFolder(query);
        Test.stopTest();
        
        // Assert
        Assert.isNotNull(result.value, 'Search results should not be null');
        Assert.areEqual(1, result.value.size(), 'Should have one search result');
    }

    @IsTest
    static void testSearchFolder_Error() {
        // Arrange
        String query = 'test query';
        
        // Act
        Test.startTest();
        TestUtils.setCustomSettingsMock();
        TestUtils.setMockResponse(400, 'Bad Request');
        try {
            Sharepoint.searchFolder('Test Folder');
            Assert.fail('Should have thrown an exception');
        } catch(Sharepoint.SharepointException e) {
            Assert.isTrue(e.getMessage().contains('400'), 'Error message should contain status code');
        }
        Test.stopTest();
    }
    
    @IsTest
    static void testCreateRecordLink() {
        // Arrange
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        SharepointDriveItem item = new SharepointDriveItem();
        item.id = '123';
        item.name = 'Test File';
        item.webUrl = 'https://test.sharepoint.com/file';
        item.parentReference = new SharepointItemReference();
        item.parentReference.driveId = 'testDriveId';
        item.parentReference.id = 'parentId';
        item.parentReference.sharepointIds = new SharepointIds();
        item.parentReference.sharepointIds.siteId = 'testSiteId';
        
        // Act
        Test.startTest();
        qkom365__O365_Metadata__c result = Sharepoint.createRecordLink(testAccount.Id, item);
        Test.stopTest();
        
        // Assert
        Assert.areEqual(testAccount.Id, result.qkom365__RelatedToId__c, 'Related record ID should match');
        Assert.areEqual(item.name, result.qkom365__Document_Name__c, 'Document name should match');
        Assert.areEqual('Folder', result.qkom365__O365Type__c, 'Type should be Folder when mimeType is blank');
    }
    
    @IsTest
    static void testNormalize() {
        // Arrange
        String input = 'Test:File*With"Special<Characters>.';
        
        // Act
        Test.startTest();
        String result = Sharepoint.normalize(input);
        Test.stopTest();
        
        // Assert
        Assert.isFalse(result.contains(':'), 'Should not contain colon');
        Assert.isFalse(result.contains('*'), 'Should not contain asterisk');
        Assert.isFalse(result.contains('"'), 'Should not contain quotes');
        Assert.isFalse(result.contains('<'), 'Should not contain less than');
        Assert.isFalse(result.endsWith('.'), 'Should not end with period');
    }



}