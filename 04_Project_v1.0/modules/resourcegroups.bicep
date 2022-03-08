targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test41'
  'test42'
  'test43'
  'test44'
  'test45'
  'test46'
  'test47'
  'test48'
  'test49'
  'test40'
]

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}] 
