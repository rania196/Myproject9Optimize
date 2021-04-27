trigger UpdateAccountCA on Order (after update) {
	
    HandlerUpdateAccountCA.UpdateAccHandler(trigger.new);
    
}