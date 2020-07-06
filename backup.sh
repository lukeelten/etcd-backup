#!/bin/bash

ns="openshift-etcd"
container="etcdctl"
pod=$(oc get po -n $ns --no-headers | grep etcd | grep Running | head -1 | awk '{print $1}')
name="backup-$(date +%Y-%m-%d)"
tmp_dir="/tmp"

oc exec -n "$ns" "$pod" -c $container -- etcdctl snapshot save "/$name"
oc rsync -n "$ns" -c "$container" "$pod:/$name" "$tmp_dir"
oc exec -n "$ns" "$pod" -c "$container" -- rm -f "/$name"

tar czf "$name.tar.gz" "$tmp_dir/$name"
rm -f "$tmp_dir/$name"
