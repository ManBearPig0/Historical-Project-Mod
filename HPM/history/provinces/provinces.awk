BEGIN { print "\"provinces\": ["}
BEGINFILE {
    split(FILENAME, fn)
    print "{"
    print "\t\"province\": "fn[1]","
}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    if ($1 == "}")
        print "\t"$1","
    else if ($3 == "{") {
        print "\t\""$1"\": "$3
        if ($4) {
            print "\t\""$4"\": "$6
            print "\t"$7","
        }
    }
    else {
        if ($3 == "yes")
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
