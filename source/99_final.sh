# Remove duplicates in PATH and PYTHONPATH

# PATH=$(echo $PATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')
# PYTHONPATH=$(echo $PYTHONPATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')
