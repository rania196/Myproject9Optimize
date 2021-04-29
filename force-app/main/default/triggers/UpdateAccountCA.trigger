trigger UpdateAccountCA on Order (after update , before update) {
	
    if (Trigger.isAfter){
        HandlerUpdateAccountCA.UpdateAccHandler(trigger.new);
    }
    

    if (Trigger.isBefore) {
        HandlerUpdateAccountCA.NetAmount(trigger.new);
	
    }
}