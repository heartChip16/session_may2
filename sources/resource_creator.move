module resource_creator_addr::resource_creator {
    // use std::signer;

    struct User has key {
        age: u64
    }

    public entry fun create_user(user_signer: &signer){
        let struct_user = User {
            age: 22
        };

        move_to(
            user_signer,
            struct_user
        )
    }

    #[test(a=0x1)]
    fun test_create_user(a:signer){
        create_user(&a);

        
    }

}