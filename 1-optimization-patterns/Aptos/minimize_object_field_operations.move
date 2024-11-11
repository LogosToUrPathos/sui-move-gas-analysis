module move_gas_optimization::minimize_object_field_operations {
    use std::signer;
    use aptos_framework::object;
    use aptos_framework::object::{Object};
    
    struct MyObject has key, store {
        value: u64
    }

    public entry fun create_object(account: &signer) {
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        
        let object = MyObject {
                value: 1
            };

        move_to(&object_signer, object);
    }

    public entry fun object_update_no_local_variable(account: &signer, object: Object<MyObject>) acquires MyObject{
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<MyObject>(object_address);

        object.value = 0;

        while (object.value < 10000) {
            object.value = object.value + 1;
        };
    }

    public entry fun object_update_with_local_variable(account: &signer, object: Object<MyObject>) acquires MyObject{
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<MyObject>(object_address);

        object.value = 0;
        let intermediate = object.value;

        while (intermediate < 10000) {
            intermediate = intermediate + 1;
        };
        object.value = intermediate;
    }
}
