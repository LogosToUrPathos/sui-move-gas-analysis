module move_gas_optimization::short_circuit2 {

    public fun expensive_function(): bool {
        let k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }

    public fun cheap_function(): bool {
        let k:u64 = 0;
        while (k < 10000) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }

    public entry fun no_short_circuit() {
        if (expensive_function() && cheap_function()) {

        };
    }

    public entry fun short_circuit() {
        if (cheap_function() && expensive_function()) {

        };
    }
}
