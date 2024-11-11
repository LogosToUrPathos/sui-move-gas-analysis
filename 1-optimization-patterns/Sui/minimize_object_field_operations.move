module move_gas_optimization::minimize_object_field_operations {
    
    public struct MyObject has key, store {
        id: UID,
        value: u64
    }

    public entry fun create_object(ctx: &mut TxContext) {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };

        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun object_update_no_local_variable(object: &mut MyObject) {
        object.value = 0;

        while (object.value < 10000) {
            object.value = object.value + 1;
            }
    }

    public entry fun object_update_with_local_variable(object: &mut MyObject) {
        object.value = 0;
        let mut intermediate = object.value;

        while (intermediate < 10000) {
            intermediate = intermediate + 1;
        };
        object.value = intermediate;
    }
}
