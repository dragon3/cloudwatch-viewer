+{
    'DBI' =>
      [ 'dbi:SQLite:dbname=development.db', '', '', +{ sqlite_unicode => 1, } ],
    'Log::Dispatch' => {
        outputs => [
            [
                'Screen::Color',
                min_level => 'debug',
                name      => 'debug',
                stderr    => 1,
                color     => { debug => { text => 'green', } }
            ],
        ],
    },
};
