@IsTest
@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class SharepointCreateRecordLinkInvocable {

    @InvocableMethod(label='Sharepoint Create Record Link' description='Creates a Q365 link between a record and a Sharepoint item')
    global static Output[] invoke(Params[] args) {
        Output[] outputs = new List<Output>();
        for (Params arg : args) {
            Output output = new Output();
            output.item = Sharepoint.createRecordLink(
                arg.recordId,
                arg.item
            );
            outputs.add(output);
        }
        return outputs;
    }

    global class Params {
        @InvocableVariable(label = 'Record ID' description='ID of record to link to' required = true)
        global String recordId;

        @InvocableVariable(label = 'Sharepoint Item' description='Sharepoint Drive Item resource' required = true)
        global SharepointDriveItem item;
    }

    global class Output {
        @InvocableVariable(label = 'Q365 Metadata' description='Metadata record representing the link between the record and Sharepoint resource')
        global qkom365__O365_Metadata__c item;
    }

}