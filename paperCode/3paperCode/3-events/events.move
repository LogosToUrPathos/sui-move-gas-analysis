/// Module: events
module events::events {
    use sui::event;

    public struct Simple has copy, drop {
        num: u64
    }

    public struct MyObject has key {
        id: UID,
        num: u64
    }

    public struct ObjectInfo has copy, drop {
        id: ID,
        sender: address
    }

    public struct ObjectInfo2 has copy, drop {
        id: ID,
        num: u64
    }

    //minimum fees
    public entry fun simple_event() {
        event::emit(Simple {num: 10});
    }

    //maximum allowed + slighlty higher fee
    public entry fun simple_event_loop() {
        let mut k:u64 = 0;
        while (k < 1024) {
            event::emit(Simple {num: k});
            k = k + 1;
        }
    }

    //much higher fees, different
    public entry fun transfer_and_event_loop(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 1024) {
            transfer_with_event(ctx);
            k = k + 1;
        }
    }
    public entry fun transfer_and_no_event_loop(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 1024) {
            transfer_with_no_event(ctx);
            k = k + 1;
        }
    }


    //no difference in fees
    public entry fun transfer_with_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        event::emit(ObjectInfo {id: id.to_inner(), sender: ctx.sender() });

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender());
    }

    public entry fun transfer_with_no_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender())
    }

    public entry fun update_object_and_event(object: &mut MyObject, new_value: u64) {
        object.num = new_value;

        event::emit(ObjectInfo2{id: object::id(object), num: new_value});
    }

    public entry fun update_object_and_event_loop(object: &mut MyObject, new_value: u64) {
        let mut k:u64 = 0;

        while(k < 1024) {
            update_object_and_event(object, new_value);
            k = k + 1;
        }
    }

    public entry fun update_object_no_event(object: &mut MyObject, new_value: u64) {
        object.num = new_value;
    }
    public entry fun update_object_no_event_loop(object: &mut MyObject, new_value: u64) {
        let mut k:u64 = 0;

        while(k < 1024) {
            update_object_no_event(object, new_value);
            k = k + 1;
        }
    }


}