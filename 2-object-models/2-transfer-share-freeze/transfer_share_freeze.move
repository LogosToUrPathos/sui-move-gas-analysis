module move_gas_optimization::share_vs_transfer {
    
    public struct MyObject has key, store {
        id: UID,
        value: u64
    }


    public fun create_object(ctx: &mut TxContext): MyObject {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };

        object
    }

    public entry fun transfer2000(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 2000) {
            transfer::transfer(create_object(ctx), tx_context::sender(ctx));
            k = k + 1;
        };
    }

    public entry fun share2000(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 2000) {
            transfer::share_object(create_object(ctx));
            k = k + 1;
        };
    }

    public entry fun freeze2000(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 2000) {
            transfer::freeze_object(create_object(ctx));
            k = k + 1;
        };
    }



}
