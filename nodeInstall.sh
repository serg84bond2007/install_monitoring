export EXP_VERSION='0.16.0'
sudo useradd --no-create-home --shell /bin/false node_exporter

cd ~
echo "DOWNLOADING PACKAGES"
curl -LO https://github.com/prometheus/node_exporter/releases/download/v$EXP_VERSION/node_exporter-$EXP_VERSION.linux-amd64.tar.gz
echo "untar packages....."
tar xvf node_exporter-$EXP_VERSION.linux-amd64.tar.gz
echo "copying binaris to bin dir"
sudo cp node_exporter-$EXP_VERSION.linux-amd64/node_exporter /usr/local/bin
echo "granting coorect permissions"
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
echo "deliting unnecessry files"
rm -rf node_exporter-$EXP_VERSION.linux-amd64.tar.gz node_exporter-$EXP_VERSION.linux-amd64

sudo bash -c 'cat << EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF'
