# Defined in - @ line 0
function lll --description alias\ lll=stat\ --format=\'\%a\ \%U\ \%G\ \%s\ \%y\ \%N\'\ \*
	stat --format='%a %U %G %s %y %N' * $argv;
end
