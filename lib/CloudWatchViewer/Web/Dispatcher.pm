package CloudWatchViewer::Web::Dispatcher;
use strict;
use warnings;
use Amon2::Web::Dispatcher::Lite;
use JSON::Syck;

any '/' => sub {
    my ($c) = @_;
    my $sth =
      $c->dbh->prepare("SELECT ts, data FROM notifications ORDER BY ts DESC");
    $sth->execute;
    my @notifications = ();
    while ( my $ref = $sth->fetchrow_arrayref ) {
        push( @notifications, _parse_notification( $ref->[0], $ref->[1] ) );
    }
    $sth->finish;
    $c->render( 'index.tt', { notifications => \@notifications } );
};

sub _parse_notification {
    my ( $ts, $json ) = @_;
    my $data         = JSON::Syck::Load($json);
    my $notification = {
        ts             => $ts,
        Type           => $data->{Type},
        Timestamp      => $data->{Timestamp},
        MessageId      => $data->{MessageId},
        Subject        => $data->{Subject} || '',
        Message        => $data->{Message},
        UnsubscribeURL => $data->{UnsubscribeURL} || '',
    };

    # ALARM
    if ( $notification->{Message} =~ /AlarmName/ ) {
        if ( $notification->{Subject} =~ /\[(OK|ALARM|INSUFFICIENT_DATA)\]/ ) {
            $notification->{AlarmType} = $1;
        }
    }
    return $notification;
}

1;
