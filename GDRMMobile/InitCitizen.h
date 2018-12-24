//
//  InitCitizen.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitCitizen : InitData


- (void)downloadCitizenforOrgID:(NSString *)orgID;


- (void)downLoadCitizenfortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;

@end
