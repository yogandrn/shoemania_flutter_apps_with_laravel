<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        
        Category::create([
            'name' => 'Sneakers'
        ]);

        Category::create([
            'name' => 'Boots'
        ]);

        Category::create([
            'name' => 'Sports'
        ]);

        Category::create([
            'name' => 'Formal'
        ]);

        Category::create([
            'name' => 'Slip On'
        ]);

        Category::create([
            'name' => 'Heels'
        ]);
    }
}
