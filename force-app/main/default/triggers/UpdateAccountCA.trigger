trigger UpdateAccountCA on Order (after update , before update) {
	
    if (Trigger.isAfter){
        HandlerUpdateAccountCA.UpdateAccHandler(trigger.new);
    }
    

    if (Trigger.isBefore) {
        Order newOrder= trigger.new[0];
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
    }
}