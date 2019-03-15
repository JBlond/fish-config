# Defined in - @ line 1
function gcl --description 'alias gcl=git clone --recurse-submodules'
	git clone --recurse-submodules $argv;
end
