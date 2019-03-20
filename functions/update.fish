# Defined in - @ line 1
function update --description 'alias update=sudo apt update'
	sudo apt update $argv;
end
