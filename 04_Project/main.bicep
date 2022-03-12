/* main file to launch infrastructure as code Project version 1.0.
Main file will call upon different modules that launch different resources.
*/

targetScope = 'subscription'

param publickey string 

@description('set the location of the deployment')
param location string = deployment().location

@description('parameters that need to be defined a.t.m.')
param resourceGroupName string = 'rg-${environment}'
param objectId string = 'de00d0e9-03c6-457c-bfff-0e295242fd26'

param environment string = 'testv1'
param tagValue object = {
  project:'1.0'
}

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

module webserv 'modules/web_serv.bicep' = {
  scope: resourceGroup
  name: 'webserv_mod'
  params: {
    location: location
    diskEncryptionId: keyVault.outputs.diskencryptionId
    environment: environment
    pubkey: publickey
    tagValues: tagValue
  }
}

module peering 'modules/network.bicep' = {
  scope: resourceGroup
  name: 'peering_mod'
  params: {
    adminvnetid: adminserv.outputs.vnetAdminiD
    adminvnetname: adminserv.outputs.adminvnetname
    webvnetid: webserv.outputs.vnetWebId
    webvnetname: webserv.outputs.webvnetname
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

module backup 'modules/backup.bicep' = {
  scope: resourceGroup
  name: 'backup_mod'
  params: {
    location: location
    adminvmId: adminserv.outputs.adminservId
    adminvmName: adminserv.outputs.adminservname
    tagValues: tagValue
    webvmId: webserv.outputs.webservId
    webvmName: webserv.outputs.webservname
  }
}
