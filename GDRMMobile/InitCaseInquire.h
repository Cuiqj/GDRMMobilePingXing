//
//  InitCaseInquire.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitCaseInquire : InitData

- (void)downloadCaseInquireforOrgID:(NSString *)orgID;

- (void)downLoadCaseInquirefortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;

@end
