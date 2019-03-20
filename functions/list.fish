# Defined in - @ line 1
function list --description 'alias list=sudo apt list --upgradable'
	sudo apt list --upgradable $argv;
end
