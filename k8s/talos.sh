#!/bin/bash
# @file talos.sh
# @brief Manage a Talos cluster.
# @description
#   This script is used to manage a Kubernetes cluster provided by Talos. Talos is started inside
#   Docker containers.
#
#   Manage a Talos cluster includes interacting with Argo CD as well.
#
#   This script provice an interactive menu to interact with Talos.
#
#   See <https://www.talos.dev/v1.8/introduction/quickstart>


readonly Y="\e[33m"
readonly D="\e[0m"


PS3='Please select the ation: '
readonly OPTION_CREATE="create"
readonly OPTION_DASHBOARD="dashboard"
readonly OPTION_DESTROY="destroy"
readonly OPTION_INFO="info"

select opt in "$OPTION_CREATE" "$OPTION_INFO" "$OPTION_DASHBOARD" "$OPTION_DESTROY"; do
    case $opt in
        "$OPTION_CREATE")
            echo -e "[INFO] $Y=== Creating Talos Cluster ==============================$D"
            talosctl cluster create
            break
        ;;
        "$OPTION_INFO")
            echo -e "[INFO] $Y=== Talos Cluster Info ==================================$D"
            echo "[INFO] --- Config Info -----------------------------------------"
            talosctl config info
            echo "[INFO] --- Cluster Info ----------------------------------------"
            talosctl cluster show
            echo "[INFO] --- Nodes Info ------------------------------------------"
            kubectl get nodes -o wide
            break
        ;;
        "$OPTION_DASHBOARD")
            echo -e "[INFO] $Y=== Starting Dashboard ==================================$D"
            talosctl dashboard --nodes 10.5.0.2
            break
        ;;
        "$OPTION_DESTROY")
            echo -e "[INFO] $Y=== Destroying Talos Cluster ============================$D"
            talosctl cluster destroy
            break
        ;;
    esac
done
