sudo apt-get install -y -qq nfs-common
sudo mkdir -p /nfs_share
if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    sudo mount $1:/nfs_share /nfs_share
    ln -sf /nfs_share ~/nfs_share
else
    echo "Invalid IP address"
    exit 1
fi

