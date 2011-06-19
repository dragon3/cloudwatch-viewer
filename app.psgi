use File::Spec;
use File::Basename;
use lib File::Spec->catdir( dirname(__FILE__), 'extlib', 'lib', 'perl5' );
use lib File::Spec->catdir( dirname(__FILE__), 'lib' );
use CloudWatchViewer::Web;
use CloudWatchViewer::API;
use Plack::Builder;

use Config::Pit;
my $config = pit_get(
    "cloudwatchviewer",
    require => {
        ba_user => 'basic auth user',
        ba_pass => 'basic auth pass',
    }
);

builder {
    enable 'Plack::Middleware::Static',
      path => qr{^(?:/static/|/robot\.txt$|/favicon.ico$)},
      root => File::Spec->catdir( dirname(__FILE__) );
    enable 'Plack::Middleware::ReverseProxy';
    mount '/api/' => CloudWatchViewer::API->to_app();
    mount '/'     => builder {
        enable "Auth::Basic", authenticator => sub {
            my ( $u, $p ) = @_;
            return $u eq $config->{ba_user} && $p eq $config->{ba_pass};
        };
        CloudWatchViewer::Web->to_app();
    };
};
