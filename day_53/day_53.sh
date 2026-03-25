sum1=$(md5sum "$file1" | cut -d ' ' -f1)
sum2=$(md5sum "$file2" | cut -d ' ' -f1)

if [ "$sum1" = "$sum2" ]; then
    echo "Files are identical"
else
    echo "Files are different"
fi