<?php

namespace App\model;

use Illuminate\Database\Eloquent\Model;

class UsersAvatars extends Model
{
    protected $fillable = [
        'user_id', 'url',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
