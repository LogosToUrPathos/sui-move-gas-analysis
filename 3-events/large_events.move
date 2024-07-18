/// Module: events
module events::large_event {
    use sui::event;

    public struct LargeEvent has copy, drop {
        num1: u64,
        num2: u64,
        num3: u64,
        num4: u64,
        vec: vector<u64>,
    }

    //minimum fees
    public entry fun single_event() {

        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let event = LargeEvent {
            num1: 1,
            num2: 2,
            num3: 3,
            num4: 4,
            vec: vec,
            };

        event::emit(event);
    }

    //maximum allowed + slighlty higher fee
    public entry fun simple_event_loop() {

        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let event = LargeEvent {
            num1: 1,
            num2: 2,
            num3: 3,
            num4: 4,
            vec: vec,
            };

        k = 0;
        while (k < 3) {
            event::emit(event);
            k = k + 1;
        }
    }



}