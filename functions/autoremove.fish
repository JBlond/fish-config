# Defined in - @ line 1
function autoremove --description 'alias autoremove=sudo apt autoremove'
	sudo apt autoremove $argv;
end
