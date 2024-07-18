module move_gas_optimization::minimize_vector_element_operations {

    public entry fun vector_update_with_local_variable(){

        let mut vec1 = vector::empty<u64>();

        let mut k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, 10);
            k = k + 1;
        };

        let mut i: u64 = 0;
        let mut result;
        let mut local_variable = vector::borrow_mut(& mut vec1, 1);
        while(i < 10000){
            result = *local_variable + 20;     
            i = i + 1;
        };
    }

    public entry fun vector_update_no_local_variable(){

        let mut vec1 = vector::empty<u64>();

        let mut k:u64 = 0;
        while (k < 10000){
            vector::push_back(&mut vec1, 10);
            k = k + 1;
        };

        let mut i: u64 = 0;
        let mut result;

        while(i < 10000){
            result = *vector::borrow_mut(& mut vec1, 1) + 20;     
            i = i + 1;
        };
    }

}
