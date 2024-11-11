module move_gas_optimization::object_vector_of_structs{
    ///Testing an object with 1 vector of a struct with 3 fields:

    /// Struct goes inside object vector, holds 3 numbers
    public struct Three_Slot_Struct has store, drop{
        field1: u64,
        field2: u64,
        field3: u64
    }

    /// Object itself, has a vector of structs. Each struct has 3 slots
    public struct Vector_of_Struct has key, store{
        id: UID,
        vec: vector<Three_Slot_Struct>
    }

    /// Function creates a Vector_of_Struct object, fills vector and transfers to caller
    public entry fun create_Vector_of_Struct(ctx: &mut TxContext){
        //1) Create empty vector to store structs
        let mut temp_vector = vector::empty<Three_Slot_Struct>();

        //2) Loop through creating struct instances & storing in vector
        let mut i = 0;
        while(i < 10000){
            //2A) Create struct instance storing values of i
            let temp_struct = Three_Slot_Struct{
                field1: i,
                field2: i,
                field3: i
            };

            //2B) Store struct into vector
            vector::push_back(&mut temp_vector, temp_struct);

            i = i + 1;
        };

        //3) Create object with previously created vector of structs
        let object = Vector_of_Struct{
            id: object::new(ctx),
            vec: temp_vector
        };

        //4) Transfer object to transaction caller
        transfer::transfer(object, tx_context::sender(ctx));
    }
    
    public entry fun obj_vector_of_struct_access(object: &mut Vector_of_Struct){
        //1) Get length of vector
        let length: u64 = vector::length(&object.vec);
        //2) Loop through vector
        let mut i: u64 = 0;
        let mut curr_num: u64;
        while(i < length){
            //2A) Access current struct within vector
            let curr_struct = vector::borrow_mut(&mut object.vec, i);
            //2B) Access each item of struct
            curr_num = curr_struct.field1;
            curr_num = curr_struct.field2;
            curr_num = curr_struct.field3;

            i = i + 1;
        }
    }

    public entry fun obj_vector_of_struct_update(object: &mut Vector_of_Struct){
        //1) Get length of vector
        let length: u64 = vector::length(&object.vec);
        //2) Loop through vector
        let mut i: u64 = 0;
        while(i < length){
            //2A) Access each struct within vector
            let curr_struct = vector::borrow_mut(&mut object.vec, i);

            //2B) Update each field of current struct
            curr_struct.field1 = 10;
            curr_struct.field2 = 20;
            curr_struct.field3 = 30;

            i = i + 1;
        }
    }
}
