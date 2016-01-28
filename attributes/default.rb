default[:accounts] =
    [
        {
            username: "a_publisher",
            password: "publisher",
            permission: "-p / a_publisher \"^hello$\" \".*\" \"^$\""
        },
        {
            username: "a_consumer",
            password: "consumer",
            permission: "-p / a_consumer \"^hello$\" \"^$\" \"hello\""
        }
    ]
