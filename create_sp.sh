groupId=$(az group show \
  --name acr1 \
  --query id --output tsv)

az ad sp create-for-rbac \
  --scope $groupId \
  --role Contributor \
  --sdk-auth # Attention, "--sdk-auth" is going to be deprecated. BUT:
  # Note: The above az ad sp create-for-rbac command will give you the --sdk-auth deprecation warning. 
  # As we are working with CLI for this deprecation process, we strongly recommend users to use this --sdk-auth flag 
  # as the result dictionary output changes and not accepted by login action if --sdk-auth is not used.

  # Note: the scope would be too large if it was only for pulling and pushing images. It is not if the sp is going to do other jobs in the rg. 

ClientId=

registryId=$(az acr show \
  --name xitryRegistryTerr2 \
  --resource-group acr1 \
  --query id --output tsv)

az role assignment create \
  --assignee $ClientId \
  --scope $registryId \
  --role AcrPush

