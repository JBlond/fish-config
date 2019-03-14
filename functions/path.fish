# Defined in - @ line 0
function path --description alias\ path=echo\ \$PATH\ \|\ tr\ \":\"\ \"\\n\"
	echo $PATH | tr " " "\n" $argv;
end
