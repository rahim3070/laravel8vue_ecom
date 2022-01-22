<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;

class OrderController extends Controller
{
    public function index()
    {
        if (Auth::user()->is_admin == 1) {
            $orders = DB::table('orders')->orderBy('id', 'DESC')->get();
        } else {
            $orders = DB::table('orders')->where('user_id', Auth::id())->orderBy('id', 'DESC')->get();
        }

        // dd($orders);
        return response()->json($orders, 200);
    }

    public function create()
    {
        //
    }

    public function store()
    {
        //
    }

    public function show()
    {
        //
    }

    public function edit($id)
    {
        $orders = DB::table('orders')->where('id', $id)->orderBy('id', 'DESC')->get();

        if ($orders) {
            return response()->json($orders, 200);
        } else {
            return response()->json('Failed', 404);
        }
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'order_status' => "required"
        ]);

        DB::table('orders')
            ->where('id', $id)
            ->update(['status' => $request->order_status]);

        return response()->json('Success', 200);
    }

    public function destroy()
    {
        //
    }

    public function search($query)
    {
        $orders = DB::table('orders')->where('order_id', 'LIKE', "%$query%")->latest()->get();

        return response()->json($orders, 200);
    }
}
