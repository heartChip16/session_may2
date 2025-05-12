module resource_creator_addr::resource_creator {
    // use std::signer;

    struct User has key, drop {
        age: u64
    }

    public entry fun create_user(user_signer: &signer) acquires User {
        let addr = signer::address_of(user_signer);
        
        if(exists<User>(addr)){
            let _ = move_from<User>(addr); // safely remove existing User resource
        };

        let struct_user = User {
            age: 22
        };
        
        move_to(
            user_signer,
            struct_user
        )
    }

    public fun update_user_age(user_address: address, user_age: u64) acquires User {
        let user = borrow_global_mut<User>(user_address);
        
        user.age = user_age;
    }

    #[view]
    public fun get_user_age(user_address: address): u64 acquires User {
        let user = borrow_global<User>(user_address);
        user.age
    }

    #[test_only]
    use std::debug;
    use std::signer;

    #[test(a=@0x1)]
    fun test_create_user(a:signer) acquires User {
        create_user(&a);

        let signer_addr = signer::address_of(&a);

        let user_age = get_user_age(signer_addr);
        debug::print(&user_age);

        update_user_age(signer_addr, 23);
        
        user_age = get_user_age(signer_addr);
        debug::print(&user_age);

    }

}