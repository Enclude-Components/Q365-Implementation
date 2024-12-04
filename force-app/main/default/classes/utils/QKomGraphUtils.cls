public with sharing class QKomGraphUtils {
    @TestVisible
    private static HttpResponse mockRes;
    public static HttpResponse send(
        HttpRequest req,
        String path
    ) {
        if (Test.isRunningTest()) {
            return mockRes;
        }
        return qkom365.GraphUtils.send(
            req,
            path
        );
    }
}