module move_gas_optimization::write_values_explicitly {
   
    public fun sum(n: u128): u128 {
        let total:u128 = 0;
        let k:u128 = 0;
        while (k < n) {
            total = total + k;
            k = k + 1;
        };
        total
    }

    public entry fun calculate() {
        let x: u128 = sum(10000);
    }


    public entry fun explicit() {
        let x: u128 = 50005000;
    }

}
