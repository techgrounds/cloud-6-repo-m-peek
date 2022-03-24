@description('values out of main')
param location string
param diskEncryptId string
param environment string 
param webNSGid string
param loadbalancerName string
param vNetWebName string
param tagValues object

@description('configurations VM')
param webscaleName string = 'webscaleset'
param webUserName string = 'webuser-${environment}'
param OSversion string = '20_04-lts-gen2'
param webnicName string = 'webnic'
param autoscaleName string = webscaleName


@description('load info from file')
param sshkey string = loadTextContent('../modules/secrets/sshpubkey.txt')
var apache_script = loadFileAsBase64('../modules/webserver_script.sh') 


// resources versie 1.1
resource webScaleset 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' = {
  name: webscaleName
  location: location
  tags: tagValues
  sku: {
    capacity: 1
    name: 'Standard_b1s'
    tier: 'Standard'
  }
  properties: {
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT10M'
    }
    doNotRunExtensionsOnOverprovisionedVMs: false
    orchestrationMode: 'Uniform'
    overprovision: false
    platformFaultDomainCount: 1
    scaleInPolicy: {
      forceDeletion: false
      rules: null
    }
    singlePlacementGroup: false
    upgradePolicy: {
      mode: 'Automatic'
      rollingUpgradePolicy: {
        maxBatchInstancePercent: 20
        maxUnhealthyInstancePercent: 20
        maxUnhealthyUpgradedInstancePercent: 20
        pauseTimeBetweenBatches: 'PT0S'
      }
    }
    virtualMachineProfile: {
      extensionProfile: {
        extensions: [
          {
            name: 'HealthExtention'
            properties: {
              autoUpgradeMinorVersion: false
              publisher: 'Microsoft.ManagedServices'
              settings: {
                protocol: 'http'
                port: 80
                requestPath: '/'
              }
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
            }
          }
        ]
      }
      hardwareProfile: {}
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: webnicName
            properties: {
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: '${webnicName}-defaultIpConfiguration'
                  properties: {
                    applicationGatewayBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', loadbalancerName, 'backendPool')
                      }
                    ]
                    primary: true
                    privateIPAddressVersion: 'IPv4'
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vNetWebName, 'backendsubnet')
                    }
                  }
                }
              ]
              networkSecurityGroup: {
                id: webNSGid
              }
              primary: true
            }
          }
        ]
      }
      osProfile: {
        allowExtensionOperations: true
        computerNamePrefix: 'webScaleset'
        adminUsername: webUserName
        customData: apache_script
        linuxConfiguration: {
          disablePasswordAuthentication: true
          ssh: {
            publicKeys: [
              {
                keyData: sshkey
                path: '/home/${webUserName}/.ssh/authorized_keys'
              }
            ]
          }
          provisionVMAgent: true
        }
        secrets: []
      }
      securityProfile: {}
      storageProfile: {
        imageReference: {
          publisher: 'canonical'
          offer: '0001-com-ubuntu-server-focal'
          sku: OSversion
          version: 'latest'
        }
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            diskEncryptionSet: {
              id: diskEncryptId
            }
            storageAccountType: 'Standard_LRS'
          }
          osType: 'Linux'
        }
      }
    }
  }
}


resource autoscaling 'Microsoft.Insights/autoscalesettings@2021-05-01-preview' = {
  name: autoscaleName
  location: location
  properties: {
    profiles: [
      {
        name: 'profile1'
        capacity: {
          maximum: '3'
          minimum: '1'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              operator: 'GreaterThan'
              metricResourceUri: resourceId('Microsoft.Compute/virtualMachineScaleSets', webscaleName) 
              timeAggregation: 'Average'
              statistic: 'Average'
              timeGrain: 'PT1M'
              threshold: 75
              metricName: 'Percentage CPU'
              timeWindow: 'PT10M'
            }
            scaleAction: {
              type: 'ChangeCount'
              direction: 'Decrease'
              cooldown: 'PT1M'
              value: '1'
            }
          }
        ]
      }
    ] 
    enabled: true
    name: webScaleset.name
    targetResourceUri: resourceId('Microsoft.Compute/virtualMachineScaleSets', webScaleset.name)
  }
}


@description('outputs of the resources')
output webscaleName string = webScaleset.name
output webscaleID string = webScaleset.id
