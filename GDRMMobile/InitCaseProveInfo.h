//
//  InitCaseProveInfo.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitCaseProveInfo : InitData

- (void)downloadCaseProveInfoforOrgID:(NSString *)orgID;

- (void)downLoadCaseProveInfofortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;

@end
