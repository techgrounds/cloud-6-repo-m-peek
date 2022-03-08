targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test31'
  'test32'
  'test33'
  'test34'
  'test35'
  'test36'
  'test37'
  'test38'
  'test39'
  'test30'
]

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}] 
