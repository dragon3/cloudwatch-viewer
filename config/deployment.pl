use Config::Pit;
my $config = pit_get(
    "cloudwatchviewer",
    require => {
        db_user => 'db user',
        db_pass => 'db pass',
        db_port => 'db port',
    }
);

return +{
    'DBI' => [
        'dbi:mysql:dbname=cwv;host=cwvdb.dragon3.dotcloud.com;port='
          . $config->{db_port},
        $config->{db_user}, $config->{db_pass},
        +{ mysql_enable_utf8 => 1, }
    ],
};
