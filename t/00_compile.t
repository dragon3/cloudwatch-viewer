use strict;
use warnings;
use Test::More;

use_ok $_ for qw(
    CloudWatchViewer
    CloudWatchViewer::Web
    CloudWatchViewer::Web::Dispatcher
);

done_testing;
