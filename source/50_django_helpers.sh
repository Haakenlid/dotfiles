######################################################
# Django helper functions

runserver()
{
    django-admin runserver_plus
    reset
}

shell()
{
    django-admin shell_plus
}

migrate()
{
    django-admin makemigrations && django-admin migrate
}