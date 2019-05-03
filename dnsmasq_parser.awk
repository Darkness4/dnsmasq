( $1 ~ /dnsmasq\[[0-9]+\]:/ ) {
        if ( $2 == "query[A]") {
                query[$3]++;
                ips[$5]++;
        } else {
                if ( $2 == "forwarded" )
                        forwarded[$3]++;
                else
                        if ( $2 == "cached" )
                                cached[$3]++;
        }
}
END {
        n = asorti(query, sorted_query)
        queries=0;
        qforwarded=0
        qacache=0
        printf " %63s |        nb  |  forwarded |  answered from cache \n", "name";
        for (i=1; i<=n; i++) {
                printf "%s%63s | %9d  | %9d  | %9d\n", \
                                ( forwarded[sorted_query[i]] > query[sorted_query[i]] ? "*" : " "), \
                                sorted_query[i], \
                                query[sorted_query[i]], \
                                forwarded[sorted_query[i]], \
                                cached[sorted_query[i]];
                nname++;
                queries += query[sorted_query[i]];
                qforwarded += forwarded[sorted_query[i]];
                qacache += cached[sorted_query[i]];
        }

        print "\n";
        printf " %53s %9d | %9d  | %9d  | %9d\n", "total:", nname, queries, qforwarded, qacache;

        print "\n";
        printf " %63s |        nb \n", "name";
        for (ip in ips) {
                printf " %63s | %9d  ", ip, ips[ip];
                nips++;
                qips +=ips[ip];
        }
        print "\n";
        printf " %53s %9d | %9d ", "total:", nips, qips;

}