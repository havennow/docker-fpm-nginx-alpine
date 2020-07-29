<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Rankings extends Model
{
    protected $fillable = [
        'semanal',
        'mensal',
        'category_id'
    ];

    public function category()
    {
        return $this->belongsTo(Categories::class);
    }

    public function users()
    {
        return $this->belongsTo(UsersRankings::class);
    }
}
