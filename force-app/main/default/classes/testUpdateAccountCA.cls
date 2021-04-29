@isTest
private class testUpdateAccountCA {
    @TestSetup static void makeData(){
    
        Account acc1 = new Account(Name = 'Test Account 1', Chiffre_d_affaire__c= 10 );
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
 
        //Create the PricebookEntry 
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

        Order o1 = new Order(AccountId = acc1.Id, Status='draft', EffectiveDate= Date.newInstance(2021, 04, 1),  Pricebook2Id = Test.getStandardPricebookId(), ShipmentCost__c = 10);
        insert o1;

        OrderItem oi1 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;        
    }
    @isTest static void TestUpdateAccountCA(){
        //selecting the order with status ordered
        Order order = [SELECT Id, Status , TotalAmount FROM Order];
        order.Status ='Ordered';
        //selecting CA account
       Account acc = [SELECT Chiffre_d_affaire__c FROM Account];
       //calculate the CA to compare it with the result
       Decimal ca = acc.Chiffre_d_affaire__c+order.TotalAmount;

        Test.startTest();
        update(order);
        Test.stopTest();
        //select the CA after updating 
        Account acc2 = [SELECT Chiffre_d_affaire__c FROM Account];

        System.assertEquals(acc2.Chiffre_d_affaire__c, ca);
    }

}
