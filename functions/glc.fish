# Defined in - @ line 1
function glc --description 'alias glc=git diff @~..@'
	git diff @~..@ $argv;
end
