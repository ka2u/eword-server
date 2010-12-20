package EWord::Web::Dispatcher;
use strict;
use warnings;

use Amon2::Web::Dispatcher::RouterSimple;

connect '/'      => 'EWord#list';
connect '/input' => 'EWord#input';
connect '/list'  => 'EWord#list';
connect '/def'   => 'EWord#definition';


1;
