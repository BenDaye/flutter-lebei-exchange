while read c1 c2; do
    curl -o "$c2.jpg" "$c1"
done < list.txt
