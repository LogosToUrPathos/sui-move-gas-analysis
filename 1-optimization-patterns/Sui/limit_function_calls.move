module move_gas_optimization::limit_function_calls {
   
   public fun helper_function() {
    }

    public entry fun function_call() {
        let mut k:u64 = 0;
        while (k < 10000) {
            helper_function();
            k = k + 1;
        };
    }
    
    public entry fun no_function_call() {
        let mut k:u64 = 0;
        while (k < 10000) {            
            k = k + 1;
        };
    }
}
