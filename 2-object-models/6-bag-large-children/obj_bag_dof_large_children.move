/// Module: bags
module bags::object_bag {
    use sui::dynamic_field;
    use sui::object_bag;

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

    public entry fun create_heroes_with_object_bag_in_dynamic_field(ctx: &mut TxContext){
        let mut i = 0;
        while (i < 20){
            let mut hero = Hero{id: object::new(ctx)};

            let mut bag_object = object_bag::new(ctx);

            let mut j: u64 = 0;
            while(j < 15) {
                let object = create_Vector_of_Struct();

                let obj = Child{id: object::new(ctx), wrapper: object};
                object_bag::add(&mut bag_object, j, obj);
                j = j + 1;
            };
            
            dynamic_field::add(&mut hero.id, b"bag", bag_object);
            transfer::transfer(hero, tx_context::sender(ctx));
            i = i + 1;
        }
    }

    public entry fun create_one_heroe_with_object_bag_in_dynamic_field(ctx: &mut TxContext){
        let mut hero = Hero{id: object::new(ctx)};

        let mut bag_object = object_bag::new(ctx);

        let mut j: u64 = 0;
        while(j < 15) {
            let object = create_Vector_of_Struct();

            let obj = Child{id: object::new(ctx), wrapper: object};
            object_bag::add(&mut bag_object, j, obj);
            j = j + 1;
        };
            
        dynamic_field::add(&mut hero.id, b"bag", bag_object);
        transfer::transfer(hero, tx_context::sender(ctx));        
    }

    public entry fun access_hero_with_object_bag_in_dynamic_field(hero_obj_ref: &mut Hero){
        let mut i = 0;
        
        let mut bag_ref: &mut object_bag::ObjectBag = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");
        let mut child: &mut Child = object_bag::borrow_mut(bag_ref, 0);
        i = i + 1;

        while (i < 1000){
            bag_ref = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");
            child = object_bag::borrow_mut(bag_ref, 0);
            i = i + 1;
        }
    }

    public entry fun update_hero_with_object_bag_in_dynamic_field(hero_obj_ref: &mut Hero){
        let mut i = 0;

        let mut bag_ref: &mut object_bag::ObjectBag = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");

        let mut child: &mut Child = object_bag::borrow_mut(bag_ref, 0);
        child.wrapper.vec.push_back(0);

        while (i < 1000){
            bag_ref = dynamic_field::borrow_mut(&mut hero_obj_ref.id, b"bag");

            child = object_bag::borrow_mut(bag_ref, 0);
            child.wrapper.vec.push_back(i);

            i = i + 1;
        }
    }
}