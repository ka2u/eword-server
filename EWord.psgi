use File::Spec;
use File::Basename;
use local::lib File::Spec->catdir(dirname(__FILE__), 'extlib');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use EWord::Web;
use Plack::Builder;

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/static/},
        root => './htdocs/';
    enable 'Plack::Middleware::ReverseProxy';
    EWord::Web->to_app();
};
