module move_gas_optimization::non_object_struct_of_vectors{
    use std::vector;

    struct Parallel_Vectors has store, drop{
        vec1: vector<u64>,
        vec2: vector<u64>,
        vec3: vector<u64>
    }

    // Creates a non-item version of a parallel vectors struct
    public entry fun non_obj_parallel_vectors_pushback(){
        //1) Create empty vectors
        let vec1 = vector::empty<u64>();
        let vec2 = vector::empty<u64>();
        let vec3 = vector::empty<u64>();

        //2) Push back to fill vectors
        let k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, k);
            vector::push_back(&mut vec2, k);
            vector::push_back(&mut vec3, k);
            k = k + 1;
        };
        //3) Create struct, setting its parallel vectors to match
        let item = Parallel_Vectors{
            vec1: vec1,
            vec2: vec2,
            vec3: vec3
        };
    }
   
    public entry fun non_obj_parallel_vectors_pushback_access(){
        //1) Run pushback on struct of parallel vectors
        //1A) Create empty vectors
        let vec1 = vector::empty<u64>();
        let vec2 = vector::empty<u64>();
        let vec3 = vector::empty<u64>();

        //1B) Push back to fill vectors
        let k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, k);
            vector::push_back(&mut vec2, k);
            vector::push_back(&mut vec3, k);
            k = k + 1;
        };
        //1C) Create struct, setting its parallel vectors to match
        let item = Parallel_Vectors{
            vec1: vec1,
            vec2: vec2,
            vec3: vec3
        };
        //2) Run Access on struct of parallel vectors
        let length: u64 = vector::length(&item.vec1);
        let i: u64 = 0;
        while(i < length){
            //2A) Loop through vector, accessing each element
            let test_num = vector::borrow_mut(&mut item.vec1, i);     //grabbing mutable reference to vector element at i

            test_num = vector::borrow_mut(&mut item.vec2, i);     //grabbing mutable reference to vector element at i

            test_num = vector::borrow_mut(&mut item.vec3, i);     //grabbing mutable reference to vector element at i
            //2B) Update loop counter
            i = i + 1;
        }      
    }



    public entry fun non_obj_parallel_vectors_pushback_update(){
        //1) Create and pushback to vectors in struct
        //1A) Create empty vectors
        let vec1 = vector::empty<u64>();
        let vec2 = vector::empty<u64>();
        let vec3 = vector::empty<u64>();

        //1B) Push back to fill vectors
        let k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, k);
            vector::push_back(&mut vec2, k);
            vector::push_back(&mut vec3, k);
            k = k + 1;
        };
        //1C) Create struct, setting its parallel vectors to match
        let item = Parallel_Vectors{
            vec1: vec1,
            vec2: vec2,
            vec3: vec3
        };

        //2) Loop through, accessing & updating every element of vector
        let length: u64 = vector::length(&item.vec1);
        let i: u64 = 0;
        while(i < length){
            //Updating vectors:
            let curr_num = vector::borrow_mut(&mut item.vec1, i);     //grabbing mutable reference to vector element at i
            *curr_num = 10;

            curr_num = vector::borrow_mut(&mut item.vec2, i);     //grabbing mutable reference to vector element at i
            *curr_num = 20;

            curr_num = vector::borrow_mut(&mut item.vec3, i);     //grabbing mutable reference to vector element at i
            *curr_num = 30;
           
            i = i + 1;
        }
    }
}
