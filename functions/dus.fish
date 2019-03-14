# Defined in - @ line 0
function dus --description 'alias dus=du -hs * | sort -h'
	du -hs * | sort -h $argv;
end
