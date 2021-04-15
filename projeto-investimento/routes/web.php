<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', ['uses' => 'Controller@homepage']);
Route::get('/cadastro',['uses' =>'Controller@cadastrar']);
Route::get('/login',['uses' =>'Controller@fazerLogin']);

/* Route::get('/', function () {
    echo "Mensagem";
    return view('welcome');
}); - REMOVIDA E DEIXADO SOMENTE A PARTE DE CIMA PARA VALIDAR O METODO DO CONTROLLER
*/
