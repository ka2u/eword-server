package EWord::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    columns qw/
        id
        mail
    /;
};

install_table word => schema {
    pk 'id';
    columns qw/
        id
        user_id
        word
        definition
        priority
    /;
};

1;
