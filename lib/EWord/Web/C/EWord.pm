package EWord::Web::C::EWord;
use strict;
use warnings;
use Data::Dumper;

sub list {
    my ($class, $c) = @_;

    my $itr = $c->db->search('word', {user_id => 1}, {order_by => 'priority'});
    my $data;
    while (my $row = $itr->next) {
        my $id   = $row->get_column('id');
        my $word = $row->get_column('word');
        push @{$data}, {$id => $word};
    }

    return $c->render_json($data);
}

sub definition {
    my ($class, $c) = @_;

    my $word = $c->request->param('word');
    my $row = $c->db->single('word', 
                         {user_id => 1, word => $word});
    my $data = {$row->get_column('id') => $row->get_column('definition')};
    return $c->render_json($data);
}

sub input {
    my ($class, $c) = @_;
}

1;
