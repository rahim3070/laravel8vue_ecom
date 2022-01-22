<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Cart;
use Auth;
use DB;
use Mail;
use App\Mail\InvoiceMail;

class PublicAPIController extends Controller
{
    public function products()
    {
        $products = DB::table('products as a')
            ->join('categories as b', 'a.category_id', '=', 'b.id')
            ->leftjoin('order_details as c', 'a.id', '=', 'c.product_id')
            ->select(DB::raw('a.id, a.slug, a.image, a.price, a.title, ((CASE WHEN sum(c.quantity) < a.qty THEN a.qty-sum(c.quantity) WHEN sum(c.quantity) > a.qty THEN 0 ELSE a.qty END)) as qty, b.name as cat_name'))
            ->groupBy('a.id', 'a.slug', 'a.image', 'a.price', 'a.title', 'a.qty', 'b.name')
            ->orderBy('a.qty', 'asc')
            ->paginate(6);

        // dd($products);
        return response()->json($products, 200);
    }

    public function search_home_products($queryText)
    {
        $products = DB::table('products as a')
            ->join('categories as b', 'a.category_id', '=', 'b.id')
            ->leftjoin('order_details as c', 'a.id', '=', 'c.product_id')
            ->where('title', 'LIKE', "%$queryText%")
            ->select(DB::raw('a.id, a.slug, a.image, a.price, a.title, ((CASE WHEN sum(c.quantity) < a.qty THEN a.qty-sum(c.quantity) WHEN sum(c.quantity) > a.qty THEN 0 ELSE a.qty END)) as qty, b.name as cat_name'))
            ->groupBy('a.id', 'a.slug', 'a.image', 'a.price', 'a.title', 'a.qty', 'b.name')
            ->orderBy('a.qty', 'asc')
            ->get();

        return response()->json($products, 200);
    }

    public function search_home_productshl($querySelect)
    {
        if ($querySelect == "hl") {
            $sort = "Desc";
        } else if ($querySelect == "lh") {
            $sort = "Asc";
        } else {
            $sort = "Asc";
        }

        $products = DB::table('products as a')
            ->join('categories as b', 'a.category_id', '=', 'b.id')
            ->leftjoin('order_details as c', 'a.id', '=', 'c.product_id')
            ->select(DB::raw('a.id, a.slug, a.image, a.price, a.title, ((CASE WHEN sum(c.quantity) < a.qty THEN a.qty-sum(c.quantity) WHEN sum(c.quantity) > a.qty THEN 0 ELSE a.qty END)) as qty, b.name as cat_name'))
            ->groupBy('a.id', 'a.slug', 'a.image', 'a.price', 'a.title', 'a.qty', 'b.name')
            ->orderBy('a.price', $sort)
            ->get();

        return response()->json($products, 200);
    }

    public function search($query)
    {
        $products = Product::where('title', 'LIKE', "%$query%")->latest()->get();

        return response()->json($products, 200);
    }

    public function product_details($slug)
    {
        $product = Product::with('category')->where('slug', $slug)->first();

        if ($product) {
            return response()->json($product, 200);
        } else {
            return response()->json('not found', 404);
        }
    }

    public function add_to_cart($pid)
    {
        $qty = 1;

        // For Qty Check
        $db_qty_check = DB::table('products as a')
            ->leftjoin('order_details as c', 'a.id', '=', 'c.product_id')
            ->select(DB::raw('((CASE WHEN sum(c.quantity) < a.qty THEN a.qty-sum(c.quantity) WHEN sum(c.quantity) > a.qty THEN 0 ELSE a.qty END)) as stock'))
            ->where('a.id', $pid)
            ->groupBy('a.qty')
            ->orderBy('a.id', 'Desc')
            ->first();
        // dd($db_qty_check->stock);

        if ($qty <= $db_qty_check->stock) {
            $product = DB::table('products')->where('id', $pid)->first();
            // dd($product);

            $cart = Cart::add([
                'id' => $product->id,
                'name' => $product->title,
                'qty' => 1,
                'price' => $product->price,
                'weight' => '0',
                'options' => ['thumbnail' => $product->image]
            ]);

            if ($cart) {
                return response()->json($cart, 200);
            } else {
                return response()->json('Not Added', 404);
            }
        } else {
            return response()->json('Not Added', 404);
        }
    }

    public function cartProductList()
    {
        $content = Cart::content();

        if ($content) {
            // dd($content);
            return response()->json($content, 200);
        } else {
            return response()->json('Not Added', 404);
        }
    }

    public function cartProductTotal()
    {
        $cartTotal = Cart::total();

        if ($cartTotal) {
            // dd($cartTotal);
            return response()->json($cartTotal, 200);
        } else {
            return response()->json('Not Added', 404);
        }
    }

    public function cartProductDelete($rowId)
    {
        if ($rowId) {
            // dd($rowId);
            Cart::remove($rowId);
            return response()->json($rowId, 200);
        } else {
            return response()->json('Not Deleted', 404);
        }
    }

    public function orderPlace()
    {
        $order = array();
        $order['order_id'] = rand(10000, 900000);
        $order['user_id'] = Auth::id();
        $order['subtotal'] = Cart::subtotal();
        $order['total'] = Cart::total();
        $order['payment_type'] = "Cash on Delivery";

        // dd($order);

        $order_id = DB::table('orders')->insertGetId($order);

        Mail::to(Auth::user()->email)->send(new InvoiceMail($order));

        //order details
        $content = Cart::content();

        $details = array();
        foreach ($content as $row) {
            $details['order_id'] = $order_id;
            $details['product_id'] = $row->id;
            $details['product_name'] = $row->name;
            $details['quantity'] = $row->qty;
            $details['single_price'] = $row->price;
            $details['subtotal_price'] = $row->price * $row->qty;

            DB::table('order_details')->insert($details);
        }

        Cart::destroy();

        return response()->json('Success', 200);
    }
}
