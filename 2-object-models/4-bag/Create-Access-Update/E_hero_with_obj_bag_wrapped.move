module move_gas_optimization::E_hero_with_obj_bag_wrapped{
    use sui::object_bag;

    public struct Hero has key, store{
        id: UID,
        bag: object_bag::ObjectBag
    }

    public struct Sword has key, store{
        id: UID,
        strength: u64
    }
    
    public struct Shield has key, store{
        id: UID,
        strength: u64
    }

    public struct Hat has key, store{
        id: UID,
        strength: u64
    }
    
    // Creates a single object that has a bag as a wrapped element
    // Also attaches 3 accessories to bag within
    public entry fun create_hero_with_wrapped_object_bag(ctx: &mut TxContext){
        let bag_object = object_bag::new(ctx);

        //1) Create hero (bag included as field)
        let mut hero = Hero{
            id: object::new(ctx),
            bag: bag_object
        };
        //2) Create accessories and attach to bag
        // creating hero attributes
        let mut sword = Sword{id: object::new(ctx), strength: 0};
        let mut shield = Shield{id: object::new(ctx), strength: 0};
        let mut hat = Hat{id: object::new(ctx), strength: 0};
        
        // adding hero attributes to bag
        object_bag::add(&mut hero.bag, 0, sword);
        object_bag::add(&mut hero.bag, 1, shield);
        object_bag::add(&mut hero.bag, 2, hat);

        //3) Transfer object to user
        transfer::transfer(hero, tx_context::sender(ctx));
    }

    // Creates a many objects that each have a bag as a wrapped element
    // Also attaches 3 accessories to bag within
    public entry fun create_heroes_with_wrapped_object_bag(ctx: &mut TxContext){
        let mut i: u64 = 0;
        while(i < 125){
            let bag_object = object_bag::new(ctx);

            //1) Create hero (bag included as field)
            let mut hero = Hero{
                id: object::new(ctx),
                bag: bag_object
            };
            //2) Create accessories and attach to bag
            // creating hero attributes
            let mut sword = Sword{id: object::new(ctx), strength: 0};
            let mut shield = Shield{id: object::new(ctx), strength: 0};
            let mut hat = Hat{id: object::new(ctx), strength: 0};
            
            // adding hero attributes to bag
            object_bag::add(&mut hero.bag, 0, sword);
            object_bag::add(&mut hero.bag, 1, shield);
            object_bag::add(&mut hero.bag, 2, hat);

            //3) Transfer object to user
            transfer::transfer(hero, tx_context::sender(ctx));
            
            i = i + 1;
        }
    }

    public entry fun access_hero_with_wrapped_object_bag(hero_obj_ref: &mut Hero){
        //1) Run 0th iteration
        let mut i = 0;
        //A) Get mutable reference to bag
        let mut bag_ref: &mut object_bag::ObjectBag = &mut hero_obj_ref.bag;
        //B) Get mut ref to bag elements
        let mut sword: &mut Sword = object_bag::borrow_mut(bag_ref, 0);
        let mut shield: &mut Shield = object_bag::borrow_mut(bag_ref, 1);
        let mut hat: &mut Hat = object_bag::borrow_mut(bag_ref, 2);
        //C) Update loop counter
        i = i + 1;
        //2) Repeatedly run access operations
        while(i < 10000){
            //A) Get mutable reference to bag
            bag_ref = &mut hero_obj_ref.bag;
            //B) Get mut ref to bag elements
            sword = object_bag::borrow_mut(bag_ref, 0);
            shield = object_bag::borrow_mut(bag_ref, 1);
            hat = object_bag::borrow_mut(bag_ref, 2);
            //C) Update loop counter
            i = i + 1;
        }
    }
    
    public entry fun update_hero_with_wrapped_object_bag(hero_obj_ref: &mut Hero){
        //1) Run 0th iteration
        let mut i = 0;
        //A) Get mutable reference to bag
        let mut bag_ref: &mut object_bag::ObjectBag = &mut hero_obj_ref.bag;
        //B) Get mut ref to & update bag elements
        let mut sword: &mut Sword = object_bag::borrow_mut(bag_ref, 0);
        sword.strength = sword.strength + 10;

        let mut shield: &mut Shield = object_bag::borrow_mut(bag_ref, 1);
        shield.strength = shield.strength + 10;

        let mut hat: &mut Hat = object_bag::borrow_mut(bag_ref, 2);
        hat.strength = hat.strength + 10;

        //C) Update loop counter
        i = i + 1;

        //2) Repeatedly run update operations
        while(i < 10000){
            //A) Get mutable reference to bag
            bag_ref = &mut hero_obj_ref.bag;
            //B) Get mut ref to & update bag elements
            sword = object_bag::borrow_mut(bag_ref, 0);
            sword.strength = sword.strength + 10;

            shield = object_bag::borrow_mut(bag_ref, 1);
            shield.strength = shield.strength + 10;
            
            hat = object_bag::borrow_mut(bag_ref, 2);
            hat.strength = hat.strength + 10;
            //C) Update loop counter
            i = i + 1;
        }
    }
}
