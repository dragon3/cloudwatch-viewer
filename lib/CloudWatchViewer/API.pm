package CloudWatchViewer::API;
use strict;
use warnings;
use parent qw/CloudWatchViewer Amon2::Web/;
use File::Spec;

# load all controller classes
use Module::Find ();
Module::Find::useall("CloudWatchViewer::API::C");

# dispatcher
use CloudWatchViewer::API::Dispatcher;

sub dispatch {
    return CloudWatchViewer::API::Dispatcher->dispatch( $_[0] )
      or die "response is not generated";
}

# load plugins
__PACKAGE__->load_plugins('Web::JSON');

1;
