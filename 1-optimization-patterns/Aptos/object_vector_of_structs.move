module move_gas_optimization::object_vector_of_structs{
    use std::signer;
    use std::vector;
    use aptos_framework::object;
    use aptos_framework::object::{Object};

    /// Struct goes inside object vector, holds 3 numbers
    struct Three_Slot_Struct has store, drop{
        field1: u64,
        field2: u64,
        field3: u64
    }

    /// Object itself, has a vector of structs. Each struct has 3 slots
    struct Vector_of_Struct has key, store{
        vec: vector<Three_Slot_Struct>
    }

    struct ObjectController has key {
        delete_ref: object::DeleteRef,
    }

    /*
        UMPIRES:
        U: (Goal, I/O, ex)
            Goal: Create vector of struct object and pass to signer
        M: (Same, Similar, Toolkit)
            My code:
                Create Parallel vector object
                Create non-obj vector of struct
            Andres create, access & update code
        P: (Draft skeleton structure of process)

        I: (Actual implementation)
        R: (Compile, Tests, Trace using same example as before.)
        E: (Evaluate time complexity, analyze -> improve efficiency.)
            O(N) complexity
        S: (Study, note down anything you learned during this process.)
            In general, best to perform first iteration before the loop.
            This can improve efficiency, instead of declaring a variable every time.
    */

    /// Creates object and uses pushback to store elements
    public entry fun create_Vector_of_Struct(account: &signer) {
        //1) Declare important references
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        //2) Build vector to store
        let vector_1 = vector::empty<Three_Slot_Struct>();
        let k:u64 = 0;

        while (k < 10000) {
            //2A) Create an instance of 3-slot struct to store into vector
            let curr_struct = Three_Slot_Struct{
                field1: k,
                field2: k,
                field3: k
            };

            //2B) Push struct into vector
            vector::push_back(&mut vector_1, curr_struct);
            k = k + 1;
        };

        //3) Create object
        let object = Vector_of_Struct{
            vec: vector_1
        };

        //4) Move object to signer
        move_to(&object_signer, ObjectController {delete_ref});
        move_to(&object_signer, object);
    }

    /// Loops through and accesses each element
    public entry fun obj_vector_of_struct_access(account: &signer, object: Object<Vector_of_Struct>) acquires Vector_of_Struct {
        //1) Declare variables
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<Vector_of_Struct>(object_address);
        let length: u64 = vector::length(&object.vec);
        let curr_num: u64;
        //2) Loop through vectors, accessing each element
        let k: u64 = 0;
        while (k < length) {
            //2A) Access current struct within vector
            let curr_struct = vector::borrow_mut(&mut object.vec, k);
            //2B) Access each item of struct
            curr_num = curr_struct.field1;
            curr_num = curr_struct.field2;
            curr_num = curr_struct.field3;
            k = k + 1;
        }
    }

    /// Loops through and updates each element
    public entry fun obj_Vector_of_Struct_update(account: &signer, object: Object<Vector_of_Struct>) acquires Vector_of_Struct {
        //1) Declare variables
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<Vector_of_Struct>(object_address);
        let length: u64 = vector::length(&object.vec);
        let curr_num: &mut u64;

        //2) Loop through vectors, updating each element
        let k: u64 = 0;
        while (k < length) {
            //2A) Access each struct within vector
            let curr_struct = vector::borrow_mut(&mut object.vec, k);

            //2B) Update each field of current struct
            curr_struct.field1 = 10;
            curr_struct.field2 = 20;
            curr_struct.field3 = 30;

            k = k + 1;
        }
    }
}
