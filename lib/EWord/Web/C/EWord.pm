package EWord::Web::C::EWord;
use strict;
use warnings;
use Data::Dumper;
use EWord::M::DictAPI;

sub list {
    my ($class, $c) = @_;

    my $itr = $c->db->search('word', {user_id => 1}, {order_by => 'priority'});
    my $data;
    while (my $row = $itr->next) {
        my $id   = $row->get_column('id');
        my $word = $row->get_column('word');
        my $def = $row->get_column('definition');
        my $priority = $row->get_column('priority');
        push @{$data}, {id => $id, word => $word, definition => $def, priority => $priority};
    }

    return $c->render_json($data);
}

sub definition {
    my ($class, $c) = @_;

    my $word = $c->request->param('word');
    my $row = $c->db->single('word', 
                         {user_id => 1, word => $word});

    my $itr = $c->db->search("word", {}, {order_by => {'priority' => 'desc'}});
    $row->update({priority => $itr->first->get_column('priority') + 1});
    my $data = {def => $row->get_column('definition')};
    return $c->render_json($data);
}

sub input {
    my ($class, $c) = @_;

    my $word = $c->request->param("word");
    my $definition = EWord::M::DictAPI->get_def("wn", $word);
    return $c->render_json({result => "error"}) unless $definition;

    my $row = $c->db->find_or_create("word",
            {
                 user_id => 1,
                 word => $word,
                 definition => $definition,
                 priority => 0,
            }
    );

    return $class->_done_result($c);
}

sub delete {
    my ($class, $c) = @_;

    my $word = $c->request->param("word");
    $c->db->delete("word", { word => $word });

    return $class->_done_result($c);
}

sub _done_result {
    my ($class, $c) = @_;
    return $c->render_json({result => "done"});
}

1;
