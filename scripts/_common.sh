#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

nodejs_version=20

#=================================================
# HELPERS
#=================================================

myynh_fix_file_permissions() {
    (
        set -x

        # /var/www/$app/
        #REMOVEME? Assuming the install dir is setup using ynh_setup_source, the proper chmod/chowns are now already applied and it shouldn't be necessary to tweak perms | chown -c -R "$app:www-data" "$install_dir"
        #REMOVEME? Assuming the install dir is setup using ynh_setup_source, the proper chmod/chowns are now already applied and it shouldn't be necessary to tweak perms | chmod -c o-rwx "$install_dir"
    )
}

myynh_setup_node_environment() {

    ynh_nodejs_install

    pushd "$install_dir" || exit

        myynh_fix_file_permissions

        # https://www.zigbee2mqtt.io/guide/installation/01_linux.html#installing
        ynh_hide_warnings ynh_exec_as_app node_load_PATH npm --version
        ynh_hide_warnings ynh_exec_as_app node_load_PATH npm ci
        ynh_hide_warnings ynh_exec_as_app node_load_PATH npm run build

        myynh_fix_file_permissions

    popd || exit
}
