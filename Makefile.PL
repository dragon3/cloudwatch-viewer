use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'CloudWatchViewer',
    AUTHOR       => 'Ryuzo Yamamoto <ryuzo.yamamoto@gmail.com>',
    VERSION_FROM => 'lib/CloudWatchViewer.pm',
    PREREQ_PM    => {
        'Amon2'                           => '2.38',
        'Amon2::DBI'                      => '0.05',
        'Text::Xslate'                    => '1.1005',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'Plack::Middleware::Auth::Basic'  => 0,
        'HTML::FillInForm::Lite'          => '1.09',
        'Time::Piece'                     => '1.20',
        'Log::Minimal'                    => '0.08',
        'JSON::Syck'                      => '0.40',
        'Furl'                            => '0.32',
        'URI::Escape'                     => '3.30',
        'IO::Socket::SSL'                 => '1.44',
        'DBD::SQLite'                     => 0,
        'DBD::mysql'                      => 0,
        'Config::Pit'                     => 0,
    },
    MIN_PERL_VERSION => '5.008001',
    ( -d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING} )
    ? ( test => { TESTS => 't/*.t xt/*.t', }, )
    : (),
);
