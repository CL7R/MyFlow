//
//  FlowCalculate.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-27.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "FlowCalculate.h"

@implementation FlowCalculate

/*获取网络流量信息*/
+(void) getNetworkBytes
{
    
    iBytes3G=0;
    iBytesWifi=0;
    iBytesOther=0;
    oBytes3G=0;
    oBytesOther=0;
    oBytesWifi=0;
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return;
    }
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        //wifi
        if (strncmp(ifa->ifa_name, "en", 2)==0)
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytesWifi += if_data->ifi_ibytes;
            oBytesWifi += if_data->ifi_obytes;
        }
        //3G
        else if(strncmp(ifa->ifa_name, "pdp_ip", 6)==0) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes3G += if_data->ifi_ibytes;
            oBytes3G += if_data->ifi_obytes;
        }
        else{
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytesOther += if_data->ifi_ibytes;
            oBytesOther += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    
    NSLog(@"\n[getInterfaceBytes-3G]%d,%d",iBytes3G,oBytes3G);
    NSLog(@"\n[getInterfaceBytes-WIFI]%d,%d",iBytesWifi,oBytesWifi);
    NSLog(@"\n[getInterfaceBytes-OTHER]%d,%d",iBytesOther,oBytesOther);
}
@end
 