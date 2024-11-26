sudo apt-get install -y -qq nfs-kernel-server
sudo mkdir -p /nfs_share
sudo chown -R nobody:nogroup /nfs_share
sudo chmod 777 /nfs_share
internal_ip=$(hostname -I | awk '{print $1}')
echo "/nfs_share  ${internal_ip}/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -ra
sudo systemctl restart nfs-kernel-server
