/* main file to launch infrastructure as code Project version 1.0.
Main file will call upon different modules that launch different resources.
In the parameterfile the parameters can be changed to make it personal.
*/

targetScope = 'subscription'

@description('set the location of the deployment')
param location string = deployment().location

@description('set the name of the resourcegroup')
param resourceGroupName string 

@description('parameters for the resources that need to be defined')
param tagValue object

param keyVaultName string

param objectId string


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module keyVault 'modules/keyvault.bicep' = {
  scope: resourceGroup
  name: keyVaultName
  params: {
    tagValue: tagValue
    location: location
    objectId: objectId
  }
}


