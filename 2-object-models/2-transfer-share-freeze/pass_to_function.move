module move_gas_optimization::pass_to_function {
    use sui::transfer;
    
    public struct MyObject has key, store {
        id: UID,
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u8,
        y:u8,
        z:u8
    }

    public entry fun empty_fun_nothing_passed(){

    }
    // Creates an object
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

    // Creates an object
    public entry fun create_and_share(ctx: &mut TxContext) {
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

        transfer::share_object(object);
    }

    // Creates an object
    public entry fun create_and_freeze(ctx: &mut TxContext) {
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

        transfer::freeze_object(object);
    }
    
    public entry fun pass_by_reference(object: &MyObject) {
        let x: u8 = object.x;   // reads value
    }

    public entry fun pass_by_mut_reference(object: &mut MyObject) {
        let x: u8 = object.x;   // reads value
    }

    // Used for comparison, repeatedly calls an empty function
    public entry fun empty_loop_nothing_passed() {
        let mut i = 0;
        while(i < 10000){
            empty_fun_nothing_passed();
            i = i + 1;
        };
    }

    public entry fun pass_by_reference_many(object: &MyObject) {
        let mut i = 0;
        while(i < 10000){
            pass_by_reference(object);
            i = i + 1;
        };
    }

    public entry fun pass_by_mut_reference_many(object: &mut MyObject) {
        let mut i = 0;
        while(i < 10000){
            pass_by_mut_reference(object);
            i = i + 1;
        };
    }

    public entry fun pass_by_value_and_transfer(object: MyObject, ctx: &mut TxContext) {
        let x: u8 = object.x;   // reads value
        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun pass_by_value_and_freeze(object: MyObject) {
        let x: u8 = object.x;   // reads value
        transfer::freeze_object(object);
    }

    public entry fun pass_by_value_and_share(object: MyObject, ctx: &mut TxContext) {   //Fails, cannot pass by value and share
        // transfer::share_object<MyObject>(object);
        transfer::share_object(object);
    }

    /*
    public entry fun pass_by_immut_ref_and_share(object: &MyObject) { 
        transfer::share_object(object); //Won't compile, can't transfer only using a reference.
    }
    */

    /*
    public entry fun pass_by_mut_ref_and_share(object: &mut MyObject) { 
        transfer::share_object(object); //Won't compile, can't transfer only using a reference.
    }
    */

    public entry fun unpack_delete_object(object: MyObject) {
        // object.x = new_value;    // won't compile - reference is not explicitely mutable
        let MyObject {
            id,
            a,
            b,
            c,
            d,
            vec,
            w,
            x: _,
            y,
            z
        } = object;

        id.delete();
    }

    /*
    public entry fun delete_object(object: MyObject, new_value: u8) {
        // object.x = new_value;    // won't compile - reference is not explicitely mutable

        // object.id.delete(); // Won't compile (considered an implicit copy, since UID has key ability, cannot copy.)

    }
    */ 

    /*
    public entry fun pass_by_value(object: MyObject) {   // Function won't compile (ownership passed to function, never transferred anywhere else.)
        //object.x = new_value;     // won't compile - reference is not explicitely mutable
    }
    */
}
