@IsTest
public class TestUtils {
    public static void setMockResponse(Integer statusCode, String response) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(statusCode);
        res.setBody(response);
        QKomGraphUtils.mockRes = res;
    }
    
    public static void setCustomSettingsMock() {
        CustomSettings.setMockValue(
            'Sharepoint_Settings__c',
            'Root_Drive__c',
            '/drives/testDriveId/root'
        );
    }
}