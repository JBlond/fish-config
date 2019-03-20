# Defined in - @ line 1
function journalctl --description 'alias journalctl=sudo journalctl'
	sudo journalctl $argv;
end
