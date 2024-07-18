module move_gas_optimization::minimize_struct_field_operations {
    public struct MyStruct has store, drop{
       value: u64
    }

    public entry fun no_local_var() {
        let mut struct1 = MyStruct {
            value: 0
        };

        while (struct1.value < 10000) {
            struct1.value = struct1.value + 1;
        }
    }

    public entry fun with_local_var() {
        let mut struct1 = MyStruct {
            value: 0
        };

        let mut local_var = struct1.value;

        while (local_var < 10000) {
            local_var = local_var + 1;
        };
        struct1.value = local_var;
    }
}
