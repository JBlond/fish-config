# Defined in - @ line 0
function lal --description alias\ lal=ls\ -a\ \|\ awk\ \'\{print\ \}\'
	ls -a | awk '{print }' $argv;
end
