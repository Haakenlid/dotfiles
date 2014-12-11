######################################################
# Django helper functions

_workon()
{
  command -v django-admin >/dev/null 2>&1 || fc -s workon
}

notebook()
{
  _workon
  fc -s 'django-admin shell_plus --notebook'
  reset
}

runserver()
{
  _workon
  django-admin runserver_plus
  reset
}

shell()
{
  _workon
  django-admin shell_plus
}

migrate()
{
  _workon
  django-admin makemigrations && django-admin migrate
}