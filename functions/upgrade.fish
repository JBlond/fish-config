# Defined in - @ line 1
function upgrade --description 'alias upgrade=sudo apt dist-upgrade'
	sudo apt dist-upgrade $argv;
end
