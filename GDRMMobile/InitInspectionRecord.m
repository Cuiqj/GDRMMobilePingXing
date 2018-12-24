//
//  InitInspectionRecord.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/12.
//

#import "InitInspectionRecord.h"

@implementation InitInspectionRecord

- (void)downloadInspectionRecordforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from InspectionRecord where inspection_id in (select id from Inspection where organization_id=%@)",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
    return [self autoParserForDataModel:@"InspectionRecord" andInXMLString:webString];
}

@end
