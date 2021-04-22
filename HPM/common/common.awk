BEGINFILE {
    split(FILENAME, fn, ".")
    print "\""fn[1]"\": ["
}
{   
    if (NF == 0 || $1 ~ /^#/)
        next
    if ($1 == "}")
        print "\t},"
    else if ($3 == "{") {
	if ($1 ~ /^color[0-9]?$/) {
            for (i = 4; i <= 6; i++) {
                $i = sprintf("%x", $i)
                if (length($i) == 1)
                    $i = "0"$i
            }
            print "\t\""$1"\": \"#"$4$5$6"\","
        }
	else
	    print "\t\""$1"\": "$3
    }
    else {
        if ($3 ~ /^"/)
            for (i = 4; i <= NF; i++)
                $3 = $3" "$i
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
    print "]"
}
