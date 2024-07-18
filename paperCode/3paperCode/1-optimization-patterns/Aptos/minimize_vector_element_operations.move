module move_gas_optimization::minimize_vector_element_operations {
    use std::vector;

    public entry fun vector_update_with_local_variable(){

        let vec1 = vector::empty<u64>();

        let k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, 10);
            k = k + 1;
        };

        let i: u64 = 0;
        let result;
        let local_variable = vector::borrow_mut(& mut vec1, 1);
        while(i < 10000){
            result = *local_variable + 20;     
            i = i + 1;
        };
    }

    public entry fun vector_update_no_local_variable(){

        let vec1 = vector::empty<u64>();

        let k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, 10);
            k = k + 1;
        };

        let i: u64 = 0;
        let result;

        while(i < 10000){
            result = *vector::borrow_mut(& mut vec1, 1) + 20;     
            i = i + 1;
        };
    }

}
