module move_gas_optimization::non_object_vector_of_structs{

    /// Struct goes inside item vector, holds 3 numbers
    public struct Three_Slot_Struct has store, drop{
        field1: u64,
        field2: u64,
        field3: u64
    }

    /// item itself, has a vector of structs. Each struct has 3 slots
    public struct Vector_of_Struct has store, drop{
        vec: vector<Three_Slot_Struct>
    }

    /// Creates & pushes elements to vector of 3-field struct
    public entry fun non_obj_create_pushback_vector_of_struct(ctx: &mut TxContext){
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

        //3) Store vector into struct
        let mut item = Vector_of_Struct{
            vec: temp_vector
        };
    }

    /// Creates & pushes back to a vector of 3-field structs, 
    /// Then performs access operation on newly created vector of structs
    public entry fun non_obj_pushback_access_vector_of_struct(){
        //1) Create & pushback to vector of struct
        //1A) Create empty vector to store structs
        let mut temp_vector = vector::empty<Three_Slot_Struct>();

        //1B) Loop through creating struct instances & storing in vector
        let mut i = 0;
        while(i < 10000){
            //1Ba) Create struct instance storing values of i
            let temp_struct = Three_Slot_Struct{
                field1: i,
                field2: i,
                field3: i
            };

            //1Bb) Store struct into vector
            vector::push_back(&mut temp_vector, temp_struct);

            i = i + 1;
        };

        //1C) Store vector into struct
        let mut item = Vector_of_Struct{
            vec: temp_vector
        };

        //2) Get length of vector
        let length: u64 = vector::length(&item.vec);
        //3) Loop through vector
        let mut i: u64 = 0;
        let mut curr_num: u64;
        while(i < length){
            //3A) Access current struct within vector
            let curr_struct = vector::borrow_mut(&mut item.vec, i);
            //3B) Access each item of struct
            curr_num = curr_struct.field1;
            curr_num = curr_struct.field2;
            curr_num = curr_struct.field3;

            i = i + 1;
        }
    }

    /// 
    public entry fun non_obj_pushback_update_vector_of_struct(){
        //1) Pushback to test vector
        //1A) Create empty vector to store structs
        let mut temp_vector = vector::empty<Three_Slot_Struct>();

        //1B) Loop through creating struct instances & storing in vector
        let mut i = 0;
        while(i < 10000){
            //1Ba) Create struct instance storing values of i
            let temp_struct = Three_Slot_Struct{
                field1: i,
                field2: i,
                field3: i
            };

            //1Bb) Store struct into vector
            vector::push_back(&mut temp_vector, temp_struct);

            i = i + 1;
        };

        //1C) Store vector into struct
        let mut item = Vector_of_Struct{
            vec: temp_vector
        };
        
        //2) Get length of vector
        let length: u64 = vector::length(&item.vec);
        //3) Loop through vector
        let mut i: u64 = 0;
        while(i < length){
            //3A) Access each struct within vector
            let curr_struct = vector::borrow_mut(&mut item.vec, i);

            //3B) Update each field of current struct
            curr_struct.field1 = 10;
            curr_struct.field2 = 20;
            curr_struct.field3 = 30;

            i = i + 1;
        }
    }
}
