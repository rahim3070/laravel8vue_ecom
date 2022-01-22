<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'is_admin' => '1',
            'name' => 'Md. Abdur Rahim',
            'email' => 'rahim3070@gmail.com',
            'password_hint' => '12345678',
            'password' => bcrypt('12345678'),
        ]);
    }
}
