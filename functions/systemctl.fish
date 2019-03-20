# Defined in - @ line 1
function systemctl --description 'alias systemctl=sudo systemctl'
	sudo systemctl $argv;
end
