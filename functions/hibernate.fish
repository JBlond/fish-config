# Defined in - @ line 1
function hibernate --description 'alias hibernate=rundll32.exe powrprof.dll,SetSuspendState'
	rundll32.exe powrprof.dll,SetSuspendState $argv;
end
