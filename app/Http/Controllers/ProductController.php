<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->latest()->get();

        return response()->json($products, 200);
    }

    public function create()
    {
        //
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required|max:255|unique:products,title',
            'price' => 'required|integer',
            'qty' => 'required|regex:/^\d*(\.\d{1,2})?$/',
            'image' => 'required|image|max:2048',
            'description' => 'required',
            'category_id' => 'required',
        ]);

        $product = Product::create([
            'title' => $request->title,
            'slug' => Str::slug($request->title),
            'price' => $request->price,
            'qty' => $request->qty,
            'description' => $request->description,
            'category_id' => $request->category_id,
        ]);

        if ($request->image) {
            $imageName = time() . '_' . uniqid() . '.' . $request->image->getClientOriginalExtension();
            $request->image->move(public_path('storage/product'), $imageName);
            $product->image = '/storage/product/' . $imageName;
            $product->save();
        }

        return response()->json($product, 200);
    }

    public function show(Product $product)
    {
        //
    }

    public function edit(Product $product)
    {
        return response()->json($product, 200);
    }

    public function update(Request $request, Product $product)
    {
        $this->validate($request, [
            'title' => "required|max:255|unique:products,title, $product->id",
            'price' => 'required|integer',
            'qty' => 'required|regex:/^\d*(\.\d{1,2})?$/',
            'image' => 'sometimes|nullable|image|max:2048',
            'description' => 'required',
            'category_id' => 'required',
        ]);

        $product->update([
            'title' => $request->title,
            'slug' => Str::slug($request->title),
            'price' => $request->price,
            'qty' => $request->qty,
            'description' => $request->description,
            'category_id' => $request->category_id,
        ]);

        if ($request->image) {
            $imageName = time() . '_' . uniqid() . '.' . $request->image->getClientOriginalExtension();
            $request->image->move(public_path('storage/product'), $imageName);
            $product->image = '/storage/product/' . $imageName;
            $product->save();
        }

        return response()->json($product, 200);
    }

    public function destroy(Product $product)
    {
        if ($product) {
            $productImage = $product->image;
            $imagePath = public_path($productImage);

            if ($productImage && file_exists($imagePath)) {
                unlink($imagePath);
            }

            $product->delete();
        } else {
            return response()->json('Product not found.', 404);
        }
    }
}
