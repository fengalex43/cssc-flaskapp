# Prerequisites:
# Have Docker running
ACR_REGISTRY=""
RESOURCE_GROUP=""
while [[ $# -gt 0 ]]; do
	key="$1"
    case $key in
		-r)
			ACR_REGISTRY="$2"
			;;
		-g)
			RESOURCE_GROUP="$2"
			;;
		acr)
			;;
		*)
			echo "Invalid input format."
			exit 1
			;;
	esac
	shift 2
done
az login
# docker login ghcr.io

# # Demo Steps
# # 0. Sign in to Azure Container Registry
az acr login -n $ACR_REGISTRY

# 1. Create a new patch workflow
./src/create-patch-workflow.sh -r $ACR_REGISTRY -g $RESOURCE_GROUP -wf continuouspatch
