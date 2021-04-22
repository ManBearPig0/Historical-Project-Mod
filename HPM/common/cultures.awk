BEGIN { print "\"cultures\": ["}
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
            print "\t\""$1"\": \"#"$4$5$6"\","
	}
	else if ($1 ~ /names$/) {
            printf "\t\""$1"\": ["
	    j = 1
	    if ($NF ~ /{/)
	        do
                    getline
	        while (NF == 0)
	    else
	        j = 4
            for (i = j; i <= NF; i++) {
		if ($i ~ /^"/)
		    while ($i !~ /"$/ && i < NF) {
                        i++
                        $i = $(i-1)" "$i
                    }
	        else if ($i != "}")
                    $i = "\""$i"\""
		else
		    break
                printf $i", "
                if (i == NF) {
                    i = 0
		    do
		        getline
		    while (NF == 0)
	        }
            }
	    print "],"
        }
	else if ($0 ~ /^\w/) {
	    print "{"
            print "\t\"culture_group\": \""$1"\","
	}
	else {
	    print "\t{"
            print "\t\"culture\": \""$1"\","
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
