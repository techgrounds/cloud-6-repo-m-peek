@description('parameters from main')
param managedId string
param keyName string
param keyvaultUri string
param location string
param tagValues object

@description('naming of the resources')
param storageAccountName string = 'storacc${uniqueString(resourceGroup().id)}'
param containerName string = 'cont${uniqueString(resourceGroup().id)}'
param apachefile string = 'webserver_script.sh'
param utcstamp string = utcNow()

resource deployWebserv 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployscript-upload-blob-${utcstamp}'
  location: location
  tags: tagValues
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.34.1'
    timeout: 'PT5M'
    environmentVariables: [
      {
        name: 'AZURE_STORAGE_ACCOUNT'
        value: storageAccountName
      }
      {
        name: 'AZURE_STORAGE_KEY'
        secureValue: storageAccount.listKeys().keys[0].value
      }
      {
        name: 'CONTENT'
        value: loadFileAsBase64('../modules/webserver_script.sh')
      }
    ]
    retentionInterval: 'PT1H'
    scriptContent: 'echo $CONTENT | base64 -d > ${apachefile} && az storage blob upload -f ${apachefile} -c ${containerName} -n ${apachefile}'
  }
}

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
    supportsHttpsTrafficOnly: false
  }
}

// create blobservice
resource blobsevice 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    automaticSnapshotPolicyEnabled: false
    changeFeed: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    deleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    isVersioningEnabled: false
    restorePolicy: {
      days: 7
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
