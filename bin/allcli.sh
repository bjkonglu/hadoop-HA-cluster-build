while :
do
echo -e "allcli>\c"
 stty erase ^H
 read command
 $(dirname "$0")/slaves.sh $command
done

