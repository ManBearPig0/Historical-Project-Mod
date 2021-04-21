BEGIN { print "\"pops\": ["}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    else if ($0 == "    }")
	print "\t},"
    else if ($0 == "}") {
        print "\t],"
        print "},"
    }
    else if ($3 == "{") {
	if ($1 ~ /^[0-9]+$/) {
	    print "{"
     	    $3 = $1
            $1 = "province"
            print "\t\""$1"\": "$3","
	    print "\t\"pops\": ["
	}
	else {
            print "\t{"
     	    $3 = $1
            $1 = "type"
            print "\t\""$1"\": \""$3"\","
        }
    }
    else {
	if ($3 ~ /^"/)
            for (i = 4; i <= NF; i++)
	        $3 = $3" "$i
        else
            $3 = "\""$3"\""
        print "\t\""$1"\": "$3","
    }
}
END { print "]"}
