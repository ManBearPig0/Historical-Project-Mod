BEGIN { print "\"countries\": ["}
BEGINFILE {
    split(FILENAME, fn, ".")
    print "{"
    print "\t\"country\": \""fn[1]"\","
}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    if ($1 == "}")
        print "\t"$1","
    else if ($3 == "{") {
        if ($1 == "color") {
	    for (i = 4; i <= 6; i++) {
                $i = sprintf("%x", $i)
                if (length($i) == 1)
                    $i = "0"$i
            }
            $3 = "\"#"$4$5$6"\","
	}
        print "\t\""$1"\": "$3
	if ($1 == "unit_names") {
            getline
	    while ($1 != "}") {
	        if (NF == 0 || $1 ~ /^#/) {
                    getline
		    continue
		}
                printf "\t\""$1"\": ["
                getline
		while ($1 != "}") {
                    for (i = 1; i <= NF; i++) {
                        if ($i ~ /^"/)
			    while ($i !~ /"$/ && i < NF) {
                                i++
                                $i = $(i-1)" "$i
                            }
			else
                            $i = "\""$i"\""
                        printf $i", "
                    } 
                    getline
	        }
		print "],"
                getline
            }
	    print "\t"$1","
	}
    }
    else {
        if ($3 ~ /^"/)
            for (i = 4; i <= NF; i++) {
                if ($i ~ /#/)
                    break
                $3 = $3" "$i
            }
        else if ($3 == "yes")
		$3 = "true"
	else if ($3 == "no")
		$3 = "false"
        else if ($3 !~ /^[0-9]+$/)
            $3 = "\""$3"\""
        print "\t\""$1"\": "$3","
    }
}
ENDFILE {
    print "},"
}
END { print "]"}
