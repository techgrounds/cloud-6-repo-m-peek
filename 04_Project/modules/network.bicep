@description('values from main')
param webvnetname string
param webvnetid string
param adminvnetname string
param adminvnetid string

resource adminvnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: adminvnetname
}

resource webvnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: webvnetname
}

resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: adminvnet
  name: '${adminvnetname}-${webvnetname}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: webvnetid
    }
  }
}


resource vnetPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: webvnet
  name: '${webvnetname}-${adminvnetname}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: adminvnetid
    }
  }
}
