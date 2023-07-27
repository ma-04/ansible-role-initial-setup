#!/usr/bin/env bash

set -x

write_results_to_db() {
    echo "insert into list (date, target, start_time, end_time, status) values (\"$1\", \"$2\", \"$3\", \"$4\", \"$5\");" | mysql -h {{ mariadb_host }} -u backup_script -p"${db_backups_password}" backups
}

script_dir=$(dirname "$(readlink -f "$0")")
. "${script_dir}"/.env-lxc-backups
db_backups_password="${db_backups_password}"

date=$(date -I)
target="${target_mail}"
start_time=$(date +"%T")
lxc_directory="{{ the_user_home }}/lxc"
lxc_name="mails.{{ domain }}"
backup_dir="{{ backup_dir }}/lxc/${lxc_name}"

mkdir -p "${backup_dir}"
chmod 700 "${backup_dir}"

systemctl stop lxc@"${lxc_name}".service && \
tar -czvf /tmp/"$(date "+%Y-%m-%dT%H")".tar.gz "${lxc_directory}"/"${lxc_name}" && \
mv tmp/"$(date "+%Y-%m-%dT%H")".tar.gz "${backup_dir}"/ && \
cp /var/lib/lxc/"${lxc_name}"/config "${backup_dir}"/"$(date "+%Y-%m-%dT%H:%M:%S")"-config && \
systemctl start lxc@"${lxc_name}".service

end_time=$(date +"%T")

if [[ $? -eq 0 ]]; then
    status="success"

    find "${backup_dir}" -mtime +8 -delete
else
    status="fail"
fi

write_results_to_db "${date}" "${target}" "${start_time}" "${end_time}" "${status}"