module table_accessories_DF::table_large{

    use sui::table;
    use sui::dynamic_field;

    // To be used in Dynamic and Dynamic Object Fields
    public struct Hero has key, store{
        id: UID
    }
    
    // vector object for table
    public struct Acc_Vector has key, store{
        id: UID,
        accessories_vector: vector<u64>
    }


// Table with 3 large vector objects 
    public entry fun create_table_dynamicField_with_vector(ctx: &mut TxContext){
        let mut i = 0;

        while(i < 10){
            // creating Hero object & table
            let mut hero = Hero{id: object::new(ctx)};
            let mut table = table::new<u64, Acc_Vector>(ctx);
            
            // creating 3 vector objects 
            let mut vector1 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };

            let mut vector2 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };
            let mut vector3 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };
            
            // filling vector objects
            let mut j = 0;
            while(j < 200) {
                vector::push_back(&mut vector1.accessories_vector, j);
                vector::push_back(&mut vector2.accessories_vector, j);
                vector::push_back(&mut vector3.accessories_vector, j);
                j = j + 1;
            };
            
            // adding vector objects into the table
            table::add(&mut table, 0, vector1);
            table::add(&mut table, 1, vector2);
            table::add(&mut table, 2, vector3);

            // adding table to Hero as Dynamic Field
            dynamic_field::add(&mut hero.id, b"inventory", table);

            // transferring ownership of the hero to ourselves
            transfer::transfer(hero, tx_context::sender(ctx));
            i = i + 1;
        }
    }


// Table with 3 small vector objects
    public entry fun create_table_dynamicField_with_vector_one_element(ctx: &mut TxContext){
        let mut i = 0;

        while(i < 10){
            // creating Hero object & table
            let mut hero = Hero{id: object::new(ctx)};
            let mut table = table::new<u64, Acc_Vector>(ctx);
           
           // creating 3 vector objects 
            let mut vector1 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };
            let mut vector2 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };
            let mut vector3 = Acc_Vector{
                id: object::new(ctx), 
                accessories_vector: vector::empty<u64>()
                };

            // filling vector with single element
            vector::push_back(&mut vector1.accessories_vector, 1);
            vector::push_back(&mut vector2.accessories_vector, 1);
            vector::push_back(&mut vector3.accessories_vector, 1);

            // adding vector objects into the table
            table::add(&mut table, 0, vector1);
            table::add(&mut table, 1, vector2);
            table::add(&mut table, 2, vector3);

            // adding table to Hero as Dynamic Field
            dynamic_field::add(&mut hero.id, b"inventory", table);

            // transferring ownership of the hero to ourselves
            transfer::transfer(hero, tx_context::sender(ctx));
            i = i + 1;
        }
    }


    public entry fun access_table_dynamicField_with_vector(hero: &mut Hero) {
        let mut i = 0;
        let mut access_value = 0u64;

        // creating reference to table to borrow Acc_Vector from the Dynamic Field
        let mut table_ref: &mut sui::table::Table<u64, Acc_Vector> = 
            dynamic_field::borrow_mut(&mut hero.id, b"inventory");

        // borrowing vector1, vector2, and vector3 Acc_Vectors from table
        let mut vector1 = table::borrow(table_ref, 0);
        let mut vector2 = table::borrow(table_ref, 1);
        let mut vector3 = table::borrow(table_ref, 2);

        // for looping through each element in the vectors
        //let mut j = 0;

        while(i < 1000) {
            // creating reference to table
            table_ref = dynamic_field::borrow_mut(&mut hero.id, b"inventory");

            // borrowing vector1, vector2, and vector3 Acc_Vectors from table
            vector1 = table::borrow(table_ref, 0);
            vector2 = table::borrow(table_ref, 1);
            vector3 = table::borrow(table_ref, 2);


            //let size = vector::length(&vector1.accessories_vector);
            // if for looping through each element in the vectors
            /*
            if(j > size - 1){
                j = 0;
            };
            */
            // accessing each element in the vectors
            // replace index 0 with j to loop through each element
            access_value = *vector::borrow(&vector1.accessories_vector, 0);
            access_value = *vector::borrow(&vector2.accessories_vector, 0);
            access_value = *vector::borrow(&vector3.accessories_vector, 0);

            //j = j + 1;
            i = i + 1;
        }
    }



    public entry fun update_table_dynamicField_with_vector(hero: &mut Hero) {
        let mut i = 0;

        // creating reference to table to borrow Acc_Vectors from the Dynamic Field
        let mut table_ref: &mut sui::table::Table<u64, Acc_Vector> = 
            dynamic_field::borrow_mut(&mut hero.id, b"inventory");

        // borrowing vector1, vector2, and vector3 Acc_Vectors from table and updating first element
        // to keep data standardized from original update function
        let mut vector1 = table::borrow_mut(table_ref, 0);
        let first_elem = vector::borrow_mut(&mut vector1.accessories_vector, 0);
        *first_elem = *first_elem + 1;

        // for looping through each element in the vectors
        //let size = vector::length(&vector1.accessories_vector);

        let mut vector2 = table::borrow_mut(table_ref, 1);
        let first_elem = vector::borrow_mut(&mut vector2.accessories_vector, 0);
        *first_elem = *first_elem + 1;

        let mut vector3 = table::borrow_mut(table_ref, 2);
        let first_elem = vector::borrow_mut(&mut vector3.accessories_vector, 0);
        *first_elem = *first_elem + 1;

        //let mut j = 0;

        while(i < 1000) {

            // for looping through each element in the vectors
            /*
            if(j > size - 1){
                j = 0;
            };
            */

            // creating reference to table
            table_ref = dynamic_field::borrow_mut(&mut hero.id, b"inventory");

            // change index 0 to j to loop through each element
            // borrowing and updating vector1, vector2, and vector3 Acc_Vectors from table
            vector1 = table::borrow_mut(table_ref, 0);
            let first_elem = vector::borrow_mut(&mut vector1.accessories_vector, 0);
            *first_elem = *first_elem + 1;

            vector2 = table::borrow_mut(table_ref, 1);
            let first_elem = vector::borrow_mut(&mut vector2.accessories_vector, 0);
            *first_elem = *first_elem + 1;

            vector3 = table::borrow_mut(table_ref, 2);
            let first_elem = vector::borrow_mut(&mut vector3.accessories_vector, 0);
            *first_elem = *first_elem + 1;

            //j = j + 1;
            i = i + 1;
        }
    }


    // ***************************************************************************************************
    // unpacking and deleting Accessories
    // helper functions to delete child vector object
    public fun delete_vector1(table_ref: &mut table::Table<u64, Acc_Vector>) {
        let Acc_Vector{id, accessories_vector: _} = table::remove(table_ref, 0);
        object::delete(id);
    }

    public fun delete_vector2(table_ref: &mut table::Table<u64, Acc_Vector>) {
        let Acc_Vector{id, accessories_vector: _} = table::remove(table_ref, 1);
        object::delete(id);
    }

    public fun delete_vector3(table_ref: &mut table::Table<u64, Acc_Vector>) {
        let Acc_Vector{id, accessories_vector: _} = table::remove(table_ref, 2);
        object::delete(id);
    }
    
    // helper function to borrow table to access and delete child vector objects
    public fun delete_table_contents_DF_with_vector(hero: &mut Hero) {
        let mut table_ref: &mut sui::table::Table<u64, Acc_Vector> = 
            dynamic_field::borrow_mut(&mut hero.id, b"inventory");

        delete_vector1(table_ref);
        delete_vector2(table_ref);
        delete_vector3(table_ref);
    }

    
    public entry fun delete_table_dynamicField_with_vector(mut hero: Hero) {
        delete_table_contents_DF_with_vector(&mut hero);

        let table_ref: table::Table<u64, Acc_Vector> = 
            dynamic_field::remove(&mut hero.id, b"inventory");
        table::destroy_empty(table_ref);
        
        let Hero{id} = hero;
        object::delete(id);
    }

}
