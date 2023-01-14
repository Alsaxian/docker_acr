groupId=$(az group show \
  --name acr1 \
  --query id --output tsv)

az ad sp create-for-rbac \
  --scope $groupId \
  --role Contributor \
  --sdk-auth # Attention, "--sdk-auth" is going to be deprecated.

ClientId=

registryId=$(az acr show \
  --name xitryRegistryTerr2 \
  --resource-group acr1 \
  --query id --output tsv)

az role assignment create \
  --assignee $ClientId \
  --scope $registryId \
  --role AcrPush

