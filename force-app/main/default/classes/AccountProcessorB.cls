global with sharing class AccountProcessorB implements Database.Batchable<sObject> {
       
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id, chiffre_d_affaire__c ,(SELECT TotalAmount FROM orders WHERE Status =\'Ordered\') from Account WHERE id IN (Select AccountId From Order WHERE Status = \'Ordered\')');
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        
        AP01Account.updateChiffreAffaire(scope);
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
}
