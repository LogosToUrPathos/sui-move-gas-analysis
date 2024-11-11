module move_gas_optimization::literal_const{
    /// Testing gas costs for referencing a const vs a literal integer in comparisons
    const NUM_ITERATIONS: u64 = 10000;  //number of loops to perform

    /// Loop comparing to literal integer
    entry fun loop_with_literal_good(){
        let i : u64 = 0;
        while(i < 10000){
            i = i + 1;
        }
    }

    /// Loop comparing to const integer
    entry fun loop_with_const_bad(){
        let i : u64 = 0;
        while(i < NUM_ITERATIONS){
            i = i + 1;
        }
    }

}