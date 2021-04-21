BEGIN { print "\"wars\": ["}
BEGINFILE {
    print "{"
}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    if ($1 == "}")
        print "\t"$1","
    else if ($3 == "{") {
        print "\t\""$1"\": "$3
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
ENDFILE {
    print "},"
}
END { print "]"}
