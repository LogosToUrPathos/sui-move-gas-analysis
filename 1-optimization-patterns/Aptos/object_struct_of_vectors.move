module move_gas_optimization::object_struct_of_vectors{
    use std::signer;
    use std::vector;
    use aptos_framework::object;
    use aptos_framework::object::{Object};

    struct Parallel_Vectors has key, store {
        vec1: vector<u64>,
        vec2: vector<u64>,
        vec3: vector<u64>
    }

    struct ObjectController has key {
        delete_ref: object::DeleteRef,
    }

    /// Empty loop, used for comparison
    public entry fun empty_loop(){
        let k:u64 = 0;
        while (k < 10000) {
            k = k + 1;
        }
    }

    /// Empty loops, used for comparison
    public entry fun two_empty_loops(){
        let k:u64 = 0;
        while (k < 10000) {
            k = k + 1;
        };

        k = 0;
        while (k < 10000) {
            k = k + 1;
        }
    }

    /// Creates object and uses pushback to store elements
    public entry fun create_object(account: &signer) {
        //1) Declare important references
        let caller_address = signer::address_of(account);
        let constructor_ref = object::create_object(caller_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);

        //2) Build vectors to store
        let vector_1 = vector::empty<u64>();
        let vector_2 = vector::empty<u64>();
        let vector_3 = vector::empty<u64>();
        let k:u64 = 0;
        while (k < 10000) {
            vector::push_back(&mut vector_1, k);
            vector::push_back(&mut vector_2, k);
            vector::push_back(&mut vector_3, k);
            k = k + 1;
        };

        //3) Create object
        let object = Parallel_Vectors {
            vec1: vector_1,
            vec2: vector_2,
            vec3: vector_3 
        };

        //4) Move object to signer
        move_to(&object_signer, ObjectController {delete_ref});
        move_to(&object_signer, object);
    }

    /// Loops through and accesses each element
    public entry fun obj_parallel_vectors_access(account: &signer, object: Object<Parallel_Vectors>) acquires Parallel_Vectors {
        //1) Declare variables
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<Parallel_Vectors>(object_address);
        let length: u64 = vector::length(&object.vec1);
        let curr_num: &mut u64;
        //2) Loop through vectors, accessing each element
        let k: u64 = 0;
        while (k < length) {
            curr_num = vector::borrow_mut(&mut object.vec1, k); //accesses element at i within vector 
            curr_num = vector::borrow_mut(&mut object.vec2, k);
            curr_num = vector::borrow_mut(&mut object.vec3, k);
            k = k + 1;
        }
    }

    /// Loops through and updates each element
    public entry fun obj_parallel_vectors_update(account: &signer, object: Object<Parallel_Vectors>) acquires Parallel_Vectors {
        //1) Declare variables
        let object_address = object::object_address(&object);
        let object = borrow_global_mut<Parallel_Vectors>(object_address);
        let length: u64 = vector::length(&object.vec1);
        let curr_num: &mut u64;
        //2) Loop through vectors, updating each element
        let k: u64 = 0;
        while (k < length) {
            curr_num = vector::borrow_mut(&mut object.vec1, k); //accesses element at i within vector 
            *curr_num = 10;

            curr_num = vector::borrow_mut(&mut object.vec2, k);
            *curr_num = 20;

            curr_num = vector::borrow_mut(&mut object.vec3, k);
            *curr_num = 30;

            k = k + 1;
        }
    }
}
