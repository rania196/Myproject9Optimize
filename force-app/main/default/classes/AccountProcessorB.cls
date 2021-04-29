public with sharing class AccountProcessorB implements Database.Batchable<sObject> {
       
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
'SELECT Id, (SELECT TotalAmount FROM orders WHERE Status =\'Actived\') from Account WHERE id IN (Select AccountId From Order WHERE Status = \'Activated\')');
        
    }
    public void execute(Database.BatchableContext bc, List<Account> accountsWithOrders){
        // process each batch of records
       
        HandlerUpdateAccountCA.UpdateAccHandler(orders);
        }
        
    public void finish(Database.BatchableContext bc){
        
        
    }
}
