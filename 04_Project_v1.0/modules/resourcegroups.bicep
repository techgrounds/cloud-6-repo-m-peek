targetScope = 'subscription'

param location string = deployment().location
param environment string

param resourceGroupNames array = [
  'vault-rg${environment}'
  'adminserv-rg${environment}'
  'webserv-rg${environment}'
  'storage-rg${environment}'
  'backup-rg${environment}'
]

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for name in resourceGroupNames: {
   name: name
  location: location 
}] 

output rg_names array = [for name in resourceGroupNames: {
  name: resourceGroup[0].name
}]
