shopt -s autocd
# If set, a command name that is the name of a directory is executed as if it
# were the argument to the cd command. This option is only used by interactive
# shells.

shopt -u cdable_vars
# If this is set, an argument to the cd builtin command that is not a directory
# is assumed to be the name of a variable whose value is the directory to change
# to.

shopt -s cdspell
# If set, minor errors in the spelling of a directory component in a cd command
# will be corrected. The errors checked for are transposed characters, a missing
# character, and a character too many. If a correction is found, the corrected
# path is printed, and the command proceeds. This option is only used by
# interactive shells.

shopt -u checkhash
# If this is set, Bash checks that a command found in the hash table exists
# before trying to execute it. If a hashed command no longer exists, a normal
# path search is performed.

shopt -u checkjobs
# If set, Bash lists the status of any stopped and running jobs before exiting
# an interactive shell. If any jobs are running, this causes the exit to be
# deferred until a second exit is attempted without an intervening command (see
# Job Control). The shell always postpones exiting if any jobs are stopped.

shopt -s checkwinsize
# If set, Bash checks the window size after each command and, if necessary,
# updates the values of LINES and COLUMNS.

shopt -s cmdhist
# If set, Bash attempts to save all lines of a multiple-line command in the same
# history entry. This allows easy re-editing of multi-line commands.

shopt -u compat31
# If set, Bash changes its behavior to that of version 3.1 with respect to
# quoted arguments to the conditional command’s ‘=~’ operator.

shopt -u compat32
# If set, Bash changes its behavior to that of version 3.2 with respect to
# locale-specific string comparison when using the ‘[[’ conditional command’s
# ‘<’ and ‘>’ operators. Bash versions prior to bash-4.0 use ASCII collation and
# strcmp(3); bash-4.1 and later use the current locale’s collation sequence and
# strcoll(3).

shopt -u compat40
# If set, Bash changes its behavior to that of version 4.0 with respect to
# locale-specific string comparison when using the ‘[[’ conditional command’s
# ‘<’ and ‘>’ operators (see previous item) and the effect of interrupting a
# command list.

shopt -u compat41
# If set, Bash, when in posix mode, treats a single quote in a double-quoted
# parameter expansion as a special character. The single quotes must match (an
# even number) and the characters between the single quotes are considered
# quoted. This is the behavior of POSIX mode through version 4.1. The default
# Bash behavior remains as in previous versions.

shopt -s complete_fullquote
# ?

shopt -u direxpand
# ?

shopt -s dirspell
# If set, Bash attempts spelling correction on directory names during word
# completion if the directory name initially supplied does not exist.

shopt -s dotglob
# If set, Bash includes filenames beginning with a ‘.’ in the results of
# filename expansion.

shopt -u execfail
# If this is set, a non-interactive shell will not exit if it cannot execute the
# file specified as an argument to the exec builtin command. An interactive
# shell does not exit if exec fails.

shopt -s expand_aliases
# If set, aliases are expanded as described below under Aliases, Aliases. This
# option is enabled by default for interactive shells.

shopt -u extdebug
# If set, behavior intended for use by debuggers is enabled: The -F option to
# the declare builtin (see Bash Builtins) displays the source file name and line
# number corresponding to each function name supplied as an argument. If the
# command run by the DEBUG trap returns a non-zero value, the next command is
# skipped and not executed. If the command run by the DEBUG trap returns a value
# of 2, and the shell is executing in a subroutine (a shell function or a shell
# script executed by the . or source builtins), a call to return is simulated.
# BASH_ARGC and BASH_ARGV are updated as described in their descriptions (see
# Bash Variables). Function tracing is enabled: command substitution, shell
# functions, and subshells invoked with ( command ) inherit the DEBUG and RETURN
# traps. Error tracing is enabled: command substitution, shell functions, and
# subshells invoked with ( command ) inherit the ERR trap.

shopt -s extglob
# If set, the extended pattern matching features described above (see Pattern
# Matching) are enabled.

shopt -s extquote
# If set, $'string' and $"string" quoting is performed within ${parameter}
# expansions enclosed in double quotes. This option is enabled by default.

shopt -u failglob
# If set, patterns which fail to match filenames during filename expansion
# result in an expansion error.

shopt -s force_fignore
# If set, the suffixes specified by the FIGNORE shell variable cause words to be
# ignored when performing word completion even if the ignored words are the only
# possible completions. See Bash Variables, for a description of FIGNORE. This
# option is enabled by default.

shopt -s globstar
# If set, the pattern ‘**’ used in a filename expansion context will match all
# files and zero or more directories and subdirectories. If the pattern is
# followed by a ‘/’, only directories and subdirectories match.

shopt -u globasciiranges
# ?

shopt -u gnu_errfmt
# If set, shell error messages are written in the standard GNU error message
# format.

shopt -s histappend
# If set, the history list is appended to the file named by the value of the
# HISTFILE variable when the shell exits, rather than overwriting the file.

shopt -s histreedit
# If set, and Readline is being used, a user is given the opportunity to re-edit
# a failed history substitution.

shopt -s histverify
# If set, and Readline is being used, the results of history substitution are
# not immediately passed to the shell parser. Instead, the resulting line is
# loaded into the Readline editing buffer, allowing further modification.

shopt -u hostcomplete
# If set, and Readline is being used, Bash will attempt to perform hostname
# completion when a word containing a ‘@’ is being completed (see Commands For
# Completion). This option is enabled by default.

shopt -u huponexit
# If set, Bash will send SIGHUP to all jobs when an interactive login shell
# exits (see Signals).

shopt -s interactive_comments
# Allow a word beginning with ‘#’ to cause that word and all remaining characters on that line to be ignored in an interactive shell. This option is enabled by default.

shopt -u lastpipe
# If set, and job control is not active, the shell runs the last command of a
# pipeline not executed in the background in the current shell environment.

shopt -s lithist
# If enabled, and the cmdhist option is enabled, multi-line commands are saved
# to the history with embedded newlines rather than using semicolon separators
# where possible.

# shopt -s login_shell
# The shell sets this option if it is started as a login shell (see Invoking
# Bash). The value may not be changed.

shopt -s mailwarn
# If set, and a file that Bash is checking for mail has been accessed since the
# last time it was checked, the message "The mail in mailfile has been read" is
# displayed.

shopt -u no_empty_cmd_completion
# If set, and Readline is being used, Bash will not attempt to search the PATH
# for possible completions when completion is attempted on an empty line.

shopt -s nocaseglob
# If set, Bash matches filenames in a case-insensitive fashion when performing
# filename expansion.

shopt -s nocasematch
# If set, Bash matches patterns in a case-insensitive fashion when performing
# matching while executing case or [[ conditional commands.

shopt -u nullglob
# If set, Bash allows filename patterns which match no files to expand to a null
# string, rather than themselves.

shopt -s progcomp
# If set, the programmable completion facilities (see Programmable Completion)
# are enabled. This option is enabled by default.

shopt -s promptvars
# If set, prompt strings undergo parameter expansion, command substitution,
# arithmetic expansion, and quote removal after being expanded as described
# below (see Printing a Prompt). This option is enabled by default.

# shopt -s restricted_shell
# The shell sets this option if it is started in restricted mode (see The
# Restricted Shell). The value may not be changed. This is not reset when the
# startup files are executed, allowing the startup files to discover whether or
# not a shell is restricted.

shopt -s shift_verbose
# If this is set, the shift builtin prints an error message when the shift count
# exceeds the number of positional parameters.

shopt -s sourcepath
# If set, the source builtin uses the value of PATH to find the directory
# containing the file supplied as an argument. This option is enabled by
# default.

shopt -u xpg_echo
# If set, the echo builtin expands backslash-escape sequences by default.
