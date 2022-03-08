targetScope = 'subscription'

param location string = deployment().location

param resourceGroupNames array = [
  'test--1'
  'test--2'
  'test--3'
  'test--4'
  'test--5'
  'test--6'
  'test--7'
  'test--8'
  'test--9'
  'test--0'
]


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames: {
   name: resourceGroupName
  location: location 
}] 
