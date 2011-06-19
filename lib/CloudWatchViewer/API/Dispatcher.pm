package CloudWatchViewer::API::Dispatcher;
use strict;
use warnings;
use Amon2::Web::Dispatcher::Lite;
use Log::Minimal;
use JSON::Syck;
use Furl;
use URI::Escape;

any '/subscribe' => sub {
    my ($c) = @_;
    my $content = $c->req->content;
    infof($content);

    my $data = JSON::Syck::Load($content);

    # TODO : check signature

    # TODO : Notification
    if ( $data->{Type} eq 'Notification' ) {
    }

    # SubscriptionConfirmation
    elsif ( $data->{Type} eq 'SubscriptionConfirmation' ) {
        my $url = $data->{SigningCertURL};
        $url =~ s|\.amazonaws\.com/.+$|.amazonaws.com/|;
        $url .= '?Action=ConfirmSubscription&Version=2010-03-31';
        $url .= '&Token=' . uri_escape( $data->{Token} );
        $url .= '&TopicArn=' . uri_escape( $data->{TopicArn} );
        infof( 'SubscriptionConfirmation request: ' . $url );

        my $furl = Furl->new( timeout => 30, );
        my $res = $furl->get($url);
        warnf( $res->status_line ) unless $res->is_success;
        infof( $res->content );
    }

    # store data
    _store( $c->dbh, $content );

    $c->render_json( {} );
};

sub _store {
    my ( $dbh, $content ) = @_;
    my $sth = $dbh->prepare("INSERT INTO notifications VALUES (?,?)");
    $sth->execute( time, $content );
    $sth->finish;
}

1;
