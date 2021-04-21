BEGIN { print "\"diplomacy\": ["}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    if ($1 == "}")
        print $1","
    else {
	if ($3 == "{") {
	    print $3
	    $3 = $1
	    $1 = "relation"
        }
	if ($3 ~ /^"/)
            for (i = 4; i <= NF; i++)
	        $3 = $3" "$i
        else
            $3 = "\""$3"\""
        print "\t\""$1"\": "$3","
    }
}
END { print "]"}
