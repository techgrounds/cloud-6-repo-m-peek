/* main file to launch infrastructure as code Project version 1.0.
Main file will call upon different modules that launch different resources.
*/

targetScope = 'subscription'

@description('set the location of the deployment')
param location string = deployment().location

@description('parameters that need to be defined a.t.m.')
param resourceGroupName string = 'rg-${environment}'
param objectId string 
param environment string = 'v1.1'
param tagValue object = {
  project:'1.1'
}
@secure()
param certPassword string
@secure()
param adminpassword string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module keyVault 'modules/keyvault.bicep' = {
  scope: resourceGroup
  name: 'keyvault_mod'
  params: {
    location: location
    tagValue: tagValue
    objectId: objectId
  }
}

module adminserv 'modules/admin_serv.bicep' = {
  scope: resourceGroup
  name: 'adminserver_mod'
  params: {
    location: location
    adminPassword: adminpassword
    diskEncryptionId: keyVault.outputs.diskencryptionId
    environment: environment
    tagValues: tagValue
  }
}

module webnetwork 'modules/web_network.bicep' = {
  scope: resourceGroup
  name: 'webnetwork_mod'
  params: {
    location: location
    environment: environment
    tagValues: tagValue
    certPassword: certPassword
    trustedIP: []
  }
}

module webserv 'modules/webserv.bicep' = {
  scope: resourceGroup
  name: 'webserver_mod'
  params: {
    location: location
    environment: environment
    tagValues: tagValue
    diskEncryptId: keyVault.outputs.diskencryptionId
    loadbalancerName: webnetwork.outputs.loadbalancerName
    vNetWebName: webnetwork.outputs.webvnetName
    webNSGid: webnetwork.outputs.webNSGid 
  }  
}

module peering 'modules/network.bicep' = {
  scope: resourceGroup
  name: 'peering_mod'
  params: {
    adminvnetid: adminserv.outputs.vnetAdminiD
    adminvnetname: adminserv.outputs.adminvnetname
    webvnetid: webnetwork.outputs.webvnetID
    webvnetname: webnetwork.outputs.webvnetName
  }
}

module storage 'modules/storage.bicep' = {
  scope: resourceGroup
  name: 'storage_mod'
  params: {
    keyName: keyVault.outputs.keyname
    keyvaultUri: keyVault.outputs.keyvaultUri
    location: location
    managedId: keyVault.outputs.managedId
    tagValues: tagValue
  }
}

