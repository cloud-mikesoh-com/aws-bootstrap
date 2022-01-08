#!/bin/bash -xe

echo 'Installing New Relic GPG Key'
curl -s 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg' | apt-key add -

echo 'Installing New Relic Repository'
printf 'deb https://download.newrelic.com/infrastructure_agent/linux/apt focal main' | tee -a /etc/apt/sources.list.d/newrelic-infra.list

echo 'Refreshing apt and installing newrelic agent'
apt-get update && apt-get install newrelic-infra -y

if [[ -f /etc/newrelic-infra.yml ]]; then
  echo 'Starting Agent...'
  systemctl start newrelic-infra
else
  echo 'New Relic Agent not installed.  The agent will not start without a license key.'
  systemctl stop newrelic-infra
fi
