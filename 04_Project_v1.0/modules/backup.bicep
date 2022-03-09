@description('parameters to get out of main file')
param location string = resourceGroup().location
//param adminservId string
//param webservId string
param tagValues object

@description('naming of the resources')
param recoveryvaultName string = 'recvault${uniqueString(resourceGroup().id)}'
param backupPoliciesName string = 'bPolicy${uniqueString(resourceGroup().id)}'
//param adminProtectName string = 'prtAdmin${uniqueString(resourceGroup().id)}'
//param webProtectName string = 'prtWeb${uniqueString(resourceGroup().id)}'

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: recoveryvaultName
  location: location
  tags: tagValues
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource backupPolicies 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-12-01' = {
  parent: recoveryVault
  name: backupPoliciesName
  location: location
  tags: tagValues
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2022-03-08T08:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2022-03-08T08:00:00Z'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

// add protected items
