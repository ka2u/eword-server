package EWord::Web::C::EWord;
use strict;
use warnings;
use Data::Dumper;
use EWord::M::DictScraper2;

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

    my $itr = $c->db->search("word", {}, {order_by => {'priority' => 'desc'}});
    $row->update({priority => $itr->first->get_column('priority') + 1});
    my $data = {$row->get_column('id') => $row->get_column('definition')};
    return $c->render_json($data);
}

sub input {
    my ($class, $c) = @_;

    my $word = $c->request->param("word");
    my $defines = EWord::M::DictScraper2->scrape($word);
    return $c->render_json({result => "error"}) unless $defines->{body};

    my $definition;
    foreach my $key (keys %{$defines}) {
        while (my $line = shift @{$defines->{$key}}) {
            next unless defined $line;
            $definition .= $line . "\n";
        }
    }

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
