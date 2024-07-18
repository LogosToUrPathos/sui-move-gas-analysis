module move_gas_optimization::read_one_vs_read_four {

    public struct MyObject has key, store {
        id: UID,
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u64,
        y:u8,
        z:u8
    }


    public entry fun create_object(ctx: &mut TxContext) {
        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let object = MyObject {
                id: object::new(ctx),
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            };

            transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun read_one_field(object: &mut MyObject) {
        let mut k:u64 = 0;
        let mut temp:u128 = 0;

        while (k < 10000) {
            temp = temp + object.b;
            k = k + 1;
        };
    }

    public entry fun read_four_fields(object: &mut MyObject) {
        let mut k:u64 = 0;
        let mut temp:u128 = 0;

        while(k < 10000) {
            temp = temp + object.a;
            temp = temp + object.b;
            temp = temp + object.c;
            temp = temp + object.d;
            k = k + 1;
        };
    }

    public entry fun write_one_field(object: &mut MyObject) {
        let y: u128 = 0;

        object.b = y;
    }

    public entry fun write_one_field2(object: &mut MyObject) {
        let mut k:u64 = 0;
        let y: u128 = 0;

        while (k < 10000) {
            object.b = y;
            k = k + 1;
        };
    }

    public entry fun write_four_fields(object: &mut MyObject) {
        let  y: u128 = 0;

        object.a = y;
        object.b = y;
        object.c = y;
        object.d = y;
    }

    public entry fun write_four_fields2(object: &mut MyObject) {
        let mut k:u64 = 0;
        let  y: u128 = 0;

        while (k < 10000) {

            object.a = y;
            object.b = y;
            object.c = y;
            object.d = y;

            k = k + 1;
        };
    }
}