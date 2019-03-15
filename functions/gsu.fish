# Defined in - @ line 1
function gsu --description 'alias gsu=git submodule update --recursive --remote'
	git submodule update --recursive --remote $argv;
end
