# Defined in - @ line 0
function upgrade --description 'alias upgrade=sudo apt dist-upgrade'
	sudo apt dist-upgrade $argv;
end
