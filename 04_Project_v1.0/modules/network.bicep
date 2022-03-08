/* this will launch
- virtual network (2)
- network peering (2)
*/

param webvnetname string
param adminvnetname string
param adminvnetid string
param webvnetid string 


resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: 
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
  parent: 
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
