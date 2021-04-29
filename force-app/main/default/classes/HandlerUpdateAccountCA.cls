public with sharing class HandlerUpdateAccountCA {
    public static void UpdateAccHandler(List<Order> orders){
        set<Id> setAccountIds = new set<Id>();
    List<Account> accountToUpdate = new List<Account>(); 
    for(integer i=0; i< orders.size(); i++){
      //  Order newOrder= trigger.new[i];
       setAccountIds.add(orders[i].AccountId);
        //Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
        //acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
        //update acc;
    }
    List<Account> v1 = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :setAccountIds];
    List<Account> accs= v1; 
    for(Account acc : accs){
        for (Order od : orders){
            if(od.AccountId==acc.Id && od.Status=='Ordered'){
                acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + od.TotalAmount;
                accountToUpdate.add(acc);
            }
        }
    }
    update accountToUpdate; 
    }

    public static void NetAmount(List<Order> order){
        //calcul du net amount pour toute la liste importé avec data loader
        for (Order od : order){
            od.NetAmount__c = od.TotalAmount - od.ShipmentCost__c;

        }
    }
}
