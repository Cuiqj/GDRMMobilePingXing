//
//  InitCaseMap.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitCaseMap : InitData


- (void)downloadCaseMapforOrgID:(NSString *)orgID;

-(void)downLoadCaseMapfortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;
@end
