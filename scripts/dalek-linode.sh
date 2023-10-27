#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	dalek-linode.sh.
## LICENSE:
###		GPLv3. <https://github.com/ciro-mota/dalek-linode/blob/main/LICENSE>
## CHANGELOG:
### 	Last Update 26/10/2023. <https://github.com/ciro-mota/dalek-linode/commits/main>

set -e

## Variables
listMachineIds=$(linode-cli linodes list --text --format "id" | tail -n +2)
listVolumesIds=$(linode-cli volumes list --text --format "id" | tail -n +2)
listNodeBalancersIds=$(linode-cli nodebalancers list --text --format "id" | tail -n +2)
listLKEIds=$(linode-cli lke clusters-list --text --format "id" | tail -n +2)
tagName=("prod"
	"Production"
	"PROD")

## Check, preserve and delete VMs:
for idM in $listMachineIds; do
	prodTagsM=$(linode-cli linodes view "$idM" --text --format tags | tail -n +2)
	machineName=$(linode-cli linodes view "$idM" --text --format label | tail -n +2)
	matched=false

	for listTags in "${tagName[@]}"; do
		if [[ "$prodTagsM" == "$listTags"* ]]; then
			echo "Preserving machine name: $machineName with tagged: $prodTagsM"
			matched=true
			break
		fi
	done

	if [[ "$machineName" == *lke* ]]; then
			echo "Preserving machine name: $machineName part of LKE cluster."
			matched=true
			break
		fi

	if [ "$matched" = false ]; then
		echo "Deleting the machine with name: $machineName"
		linode-cli linodes delete --suppress-warnings "$idM"
	fi
done

## Check, preserve and delete Volumes:
for idV in $listVolumesIds; do
	prodTagsV=$(linode-cli volumes view "$idV" --text --format tags | tail -n +2)
	volumeName=$(linode-cli volumes view "$idV" --text --format label | tail -n +2)
	matched=false

	for listTags in "${tagName[@]}"; do
		if [[ "$prodTagsV" == "$listTags"* ]]; then
			echo "Preserving volume name: $volumeName with tagged: $prodTagsV"
			matched=true
			break
		fi
	done

	if [ "$matched" = false ]; then
		echo "Deleting the volume with name: $volumeName"
		linode-cli volumes delete --suppress-warnings "$idV"
	fi
done

## Check, preserve and delete Nodebalancers:
for idB in $listNodeBalancersIds; do
	prodTagsNB=$(linode-cli nodebalancers view "$idB" --text --format tags | tail -n +2)
	NBName=$(linode-cli nodebalancers view "$idB" --text --format label | tail -n +2)
	matched=false

	for listTags in "${tagName[@]}"; do
		if [[ "$prodTagsNB" == "$listTags"* ]]; then
			echo "Preserving NodeBalancers name: $NBName with tagged: $prodTagsNB"
			matched=true
			break
		fi
	done

	if [ "$matched" = false ]; then
		echo "Deleting the NodeBalancers with name: $NBName"
		linode-cli nodebalancers delete --suppress-warnings "$idB"
	fi
done

## Check, preserve and delete Linode Kubernets:
for idL in $listLKEIds; do
	prodTagsLKE=$(linode-cli lke cluster-view "$idL" --text --format tags | tail -n +2)
	LKEName=$(linode-cli lke cluster-view "$idL" --text --format label | tail -n +2)
	matched=false

	for listTags in "${tagName[@]}"; do
		if [[ "$prodTagsLKE" == "$listTags"* ]]; then
			echo "Preserving cluster name: $LKEName with tagged: $prodTagsLKE"
			matched=true
			break
		fi
	done

	if [ "$matched" = false ]; then
		echo "Deleting the cluster with name: $LKEName"
		linode-cli lke cluster-delete --suppress-warnings "$idL"
	fi
done

echo "Nothing more to do."