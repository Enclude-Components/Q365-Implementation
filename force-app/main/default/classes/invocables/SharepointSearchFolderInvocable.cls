@IsTest
@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class SharepointSearchFolderInvocable {

    @InvocableMethod(label='Sharepoint Search Folder' description='Searches a folder in the Sharepoint base drive with the specified name')
    global static Output[] invoke(Params[] args) {
        Output[] outputs = new List<Output>();
        for (Params arg : args) {
            Output output = new Output();
            SharepointSearchResponse res = Sharepoint.searchFolder(arg.query);
            output.results = res.value;
            outputs.add(output);
        }
        return outputs;
    }

    global class Params {
        @InvocableVariable(label = 'Search Term' description='Text to search for' required = true)
        global String query;
    }

    global class Output {
        @InvocableVariable(label = 'Results' description='Items returned by the search results')
        global SharepointDriveItem[] results;
    }

}