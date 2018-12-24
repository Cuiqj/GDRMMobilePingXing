//
//  InitCaseDeformation.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/11.
//

#import "InitData.h"

@interface InitCaseDeformation : InitData


- (void)downloadCaseDeformationforOrgID:(NSString *)orgID;

- (void)downLoadCaseDeformationfortable:(NSString *)table withorgID:(NSString *)orgID withtypeID:(NSString *)typeID;

@end
