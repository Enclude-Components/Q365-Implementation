@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class SharepointCreateFolderInvocable {

    @InvocableMethod(label='Sharepoint Create Folder' description='Creates a folder in the Sharepoint base drive with the specified name')
    global static Output[] invoke(Params[] args) {
        Output[] outputs = new List<Output>();
        for (Params arg : args) {
            Output output = new Output();
            output.item = Sharepoint.createFolder(arg.name);
            outputs.add(output);
        }
        return outputs;
    }

    global class Params {
        @InvocableVariable(label = 'Name' description='Name to give created folder' required = true)
        global String name;
    }

    global class Output {
        @InvocableVariable(label = 'Sharepoint Folder' description='Details of the created folder')
        global SharepointDriveItem item;
    }

}