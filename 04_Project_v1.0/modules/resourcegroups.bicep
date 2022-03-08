targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test21'
  'test22'
  'test23'
  'test24'
  'test25'
  'test26'
  'test27'
  'test28'
  'test29'
  'test20'
]

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}] 
