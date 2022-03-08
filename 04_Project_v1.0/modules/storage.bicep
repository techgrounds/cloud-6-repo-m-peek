/* module needs work, is not tested
this will launch:
- storage account
- blobservice
- container
*/

targetScope = 'resourceGroup'

@description('outputs of other files to use')
param managedId string
param keyName string
param keyvaultUri string

@description('location for the resources')
param location string

@description('tags for the resources')
param tagValues object

@description('naming of the resources')
param storageAccountName string = 'storacc${uniqueString(resourceGroup().id)}'
param storageblobName string = 'storblob${uniqueString(resourceGroup().id)}'
param containerName string = 'cont${uniqueString(resourceGroup().id)}'

// create storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  tags: tagValues
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedId}': {}
    }
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    encryption: {
      identity: {
        userAssignedIdentity: managedId
      }
      keySource: 'Microsoft.Keyvault'
      keyvaultproperties: {
        keyname: keyName
        keyvaulturi: keyvaultUri
      }
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        queue: {
          enabled: true
          keyType: 'Account'
        }
        table: {
          enabled: true
          keyType: 'Account'
        }
      }
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
  }
}

// create blobservice
resource blobsevice 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  name: storageblobName
  parent: storageAccount
  properties: {
    changeFeed: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    isVersioningEnabled: false
    restorePolicy: {
      enabled: false
    }
  }
}

// create container
resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: containerName
  parent: blobsevice
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
}

@description('output of the resources')
output storageNameOut string = storageAccount.name
output containerNameOut string = storageContainer.name
