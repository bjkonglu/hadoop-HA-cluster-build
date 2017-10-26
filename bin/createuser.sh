groupadd hadoop
for UU in hadp yarn mapred
do
useradd -U -G hadoop $UU
echo $UU | passwd --stdin $UU
su - $UU -c ssh-keygen
done

