
#!/bin/bash
set -x

[[ -z "${RAW_IMAGE_URL}" ]] && echo "RAW_IMAGE_URL is not set" && exit 1
[[ -z "${AZURE_RESOURCE_GROUP_NAME}" ]] && echo "AZURE_RESOURCE_GROUP_NAME is not set" && exit 1
[[ -z "${HYPERV_GENERATION}" ]] && echo "HYPERV_GENERATION is not set" && exit 1
[[ -z "${OS_TYPE}" ]] && echo "OS_TYPE is not set" && exit 1

CREATE_TIME="$(date +%s)"

IMPORTED_IMAGE_NAME="imported-$CREATE_TIME-$RANDOM"

echo "Creating new image for a custom VHD ${RAW_IMAGE_URL}"

eval "az image create --resource-group ${AZURE_RESOURCE_GROUP_NAME} --name ${IMPORTED_IMAGE_NAME} --os-type ${OS_TYPE} --hyper-v-generation ${hyperv_generation} --hyper-v-generation ${HYPERV_GENERATION} --source ${RAW_IMAGE_URL}"