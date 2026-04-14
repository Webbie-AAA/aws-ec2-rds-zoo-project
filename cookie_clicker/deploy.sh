# make sure a pemkey exists and has the right permissions
if [ ! -f .pemkey ]; then
    echo "No .pemkey file found. Please create one."
    exit 1
fi

# set the correct permissions on the pemkey (chmod 400 grants read-only access to the owner)
chmod 400 .pemkey

# ask the user for their ec2 location to connect to
echo "What is your Public IPv4 DNS (e.g. ec2-18-133-253-1.eu-west-2.compute.amazonaws.com):"
read public_dns

# copy server.py to the EC2 instance
echo '🚀 Uploading files to EC2 instance...'
scp -i .pemkey -r ./server.py ec2-user@${public_dns}:.
echo '✨ Upload complete'