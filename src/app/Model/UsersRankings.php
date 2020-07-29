<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class UsersRankings extends Model
{
    protected $fillable = [
        'user_id',
        'ranking_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function ranking()
    {
        return $this->belongsTo(Rankings::class);
    }
}
