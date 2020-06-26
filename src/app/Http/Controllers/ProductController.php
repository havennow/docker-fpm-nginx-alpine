<?php

namespace App\Http\Controllers;

use App\Model\Products;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function getProducts()
    {
        $model = Products::all();

        return response()->json($model);
    }
}
