/* main file to launch infrastructure as code Project version 1.0.
Main file will call upon different modules that launch different resources.
*/

targetScope = 'subscription'

@description('set the location of the deployment')
param location string = deployment().location

@description('parameters that need to be defined a.t.m.')
param resourceGroupName string 
param objectId string = 'de00d0e9-03c6-457c-bfff-0e295242fd26'
param publickey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQs1xF11mYdmWMSa8DYsez0XIQw2LMf9jr7TmAXSg1vfl0q1dd8p6PcuNFqNH7eXz+AGhBAXcDMUe4Vtu1nEMp5ck9TMH1SXEl5uK0ogNWfehHzVM+6KFNIq9WQSwsZGibdRN75Qm3ZbZseIILvKMfPO+1FX0nbo+N9I240QQDCq7rGgSRZ6IiW6n4Wgh9zMP+eWnYEni8LAwRGprhZy8nszf9l8Cpzflgc+KrjPgfcw6i12kp/ZL+cTiHZrO+glIjnnSMUrlpX3rRZjUbJmLyIoVCUj8PVW9KgWgDfG3XeMjqoOQu9QSuCY4rdeaMK4qPeTodORVwYi9Yhe5NiGswdNaImh3TeMeIZjuBBQo/5x7iNTMg+4k5uDd9S89vMNJeCgdaMBC3RSHkpHBijcB0PukapEZbIPThn49JlzssfAn42K+XcRCrmta5MoSN4kwCysGxyxONT0S/LrFP9uWlJ8zjWKMpJJl4xwN7X/23qqsYlzcX9SDyjy5MVOhnRrkyGymu3ASzDdAHmX7IaXiWwyVEhWkldrEkmBEuAzI4dLCJUTPL+6WUdMfPtGud4m1wYfRg9BLrKSxn+3MdTDkp1GGGfay9AQBs4XWfkKkz6IKyu6VgFhtVD8eH+pPE/LlZPDJ1xl/A+BVIyXx1s+UhFwrVCohmQPH1KtwZ3BSnNw== mylen@LAPTOP-CSG64OIC'
param environment string = 'testing'
param tagValue object = {
  project:'1.0'
}

@secure()
param adminpassword string
@secure()
param webpassword string 


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
    webPassword: webpassword
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


