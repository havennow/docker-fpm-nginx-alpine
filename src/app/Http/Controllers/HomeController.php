<?php

namespace App\Http\Controllers;

use App\Model\Categories;
use App\model\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class HomeController extends Controller
{
    public function index(Request $request)
    {
        $category = $request->input('cat', 'mc');

        $rankings = User::query()
            ->join('users_rankings', 'users_rankings.user_id', '=', 'users.id' )
            ->join('rankings', 'rankings.id', '=', 'users_rankings.ranking_id' )
            ->join('categories', 'categories.id', '=', 'rankings.category_id' )
            ->join('users_avatars', 'users_avatars.user_id', '=', 'users.id' )
            ->where(['categories.name' => $category])->get()->toArray();


        Cache::remember('test', 100, function () use ($rankings) {
            return $rankings;
        });

        $teste = Cache::get('test');

        dd($teste);


       $category = Categories::all();

       return response()->json(['categories' => $category, 'users' =>  $rankings]);
    }
}
