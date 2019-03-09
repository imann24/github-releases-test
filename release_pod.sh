#!/usr/bin/env bash
# run at the base of your spec repo
# usage ./release_pod.sh <pod name> <repo owner> <repo name> <token>
pod_name=$1
repo_owner=$2
repo_name=$3
repo_token=$4
pod_version=$(grep s.version $pod_name.podspec -m 1 | grep -o '"[^"]\+"'  | tr -d "\"")
request_body=$(echo "{'tag_name': 'v${pod_version}',
                      'target_commitish': 'master',
                      'name': 'v${pod_version}',
                      'body': 'Release of version ${pod_version}',
                      'draft': false,
                      'prerelease': false}" | sed "s/'/\"/g")
curl --data "$request_body" https://api.github.com/repos/${repo_owner}/${repo_name}/releases?access_token=${repo_token}
