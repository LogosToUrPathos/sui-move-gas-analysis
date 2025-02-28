/// Module: bags
module bags::bag{
    use sui::dynamic_field;
    use sui::bag;

    public struct Hero has key, store {
        id: UID
    }

    public struct Wrapper has store, drop {
        vec: vector<u64>,
    }

    public struct Child has key, store {
        id: UID,
        wrapper: Wrapper
    }

     public fun create_Vector_of_Struct(): Wrapper{
        let mut temp_vector = vector::empty<u64>();

        let mut i = 0;
        while(i < 100){
            vector::push_back(&mut temp_vector, i);            
            i = i + 1;
        };

        let object = Wrapper{
            vec: temp_vector
        };

        object
    }

    public entry fun create_heroes_with_bag_in_dynamic_field(ctx: &mut TxContext){
        let mut i = 0;
        while (i < 20){
            let mut hero = Hero{id: object::new(ctx)};

            let mut bag_object = bag::new(ctx);

            let mut j: u64 = 0;
            while(j < 15) {
                let object = create_Vector_of_Struct();

                let obj = Child{id: object::new(ctx), wrapper: object};
                bag::add(&mut bag_object, j, obj);
                j = j + 1;
            };
            
            dynamic_field::add(&mut hero.id, b"bag", bag_object);
            transfer::transfer(hero, tx_context::sender(ctx));
            i = i + 1;
        }
    }

    public entry fun create_one_heroe_with_bag_in_dynamic_field(ctx: &mut TxContext){
        let mut hero = Hero{id: object::new(ctx)};

        let mut bag_object = bag::new(ctx);

        let mut j: u64 = 0;
        while(j < 15) {
            let object = create_Vector_of_Struct();

            let obj = Child{id: object::new(ctx), wrapper: object};
            bag::add(&mut bag_object, j, obj);
            j = j + 1;
        };
            
        dynamic_field::add(&mut hero.id, b"bag", bag_object);
        transfer::transfer(hero, tx_context::sender(ctx));        
    }

    public entry fun access_hero_with_bag_in_dynamic_field(hero_obj_ref: &mut Hero){
        let mut i = 0;
        
        let mut bag_ref: &mut bag::Bag = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");
        let mut child: &mut Child;
        
        while(i < 10) {
            let mut j = 0;
            while (j < 15){
                bag_ref = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");
                child = bag::borrow_mut(bag_ref, j);

                let mut k = 0;
                while(k < 100) {
                    let curr_num = vector::borrow_mut(&mut child.wrapper.vec, k);

                    k = k + 1;
                };
                j = j + 1;
            };
            i = i + 1;
        }
    }

    public entry fun update_hero_with_bag_in_dynamic_field(hero_obj_ref: &mut Hero){
        let mut i = 0;

        let mut bag_ref: &mut bag::Bag;
        let mut child: &mut Child;

        while(i < 10) {
            let mut j = 0;
            while (j < 15){
                bag_ref = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");
                child = bag::borrow_mut(bag_ref, j);

                let mut k = 0;
                while(k < 100) {
                    let curr_num: &mut u64 = vector::borrow_mut(&mut child.wrapper.vec, k);
                    *curr_num = k;
                    
                    k = k + 1;
                };
                j = j + 1;
            };
            i = i + 1;
        }
    }
}