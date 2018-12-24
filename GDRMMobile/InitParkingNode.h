//
//  InitParkingNode.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitParkingNode : InitData


- (void)downloadParkingNodeforOrgID:(NSString *)orgID;

- (void)downLoadParkingNodefortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;
@end
