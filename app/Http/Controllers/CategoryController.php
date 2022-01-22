<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::latest()->get();

        return response()->json($categories, 200);
    }

    public function create()
    {
        //
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
        ]);

        $category = Category::create([
            'name' => $request->name,
            'slug' => Str::slug($request->name),
        ]);

        if ($category) {
            return response()->json('Success', 200);
        } else {
            return response()->json('Failed', 404);
        }
    }

    public function show(Category $category)
    {
        //
    }

    public function edit(Category $category)
    {
        if ($category) {
            return response()->json($category, 200);
        } else {
            return response()->json('Failed', 404);
        }
    }

    public function update(Request $request, Category $category)
    {
        $this->validate($request, [
            'name' => "required|unique:categories,name, $category->id"
        ]);

        $category->update([
            'name' => $request->name,
            'slug' => Str::slug($request->name),
        ]);

        if ($category) {
            return response()->json('Success', 200);
        } else {
            return response()->json('Failed', 404);
        }
    }

    public function destroy(Category $category)
    {
        if ($category) {
            $category->delete();

            return response()->json('Success', 200);
        } else {
            return response()->json('Failed', 404);
        }
    }
}
