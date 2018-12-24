//
//  InitInspectionPath.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/12.
//

#import "InitInspectionPath.h"

@implementation InitInspectionPath

- (void)downloadInspectionPathforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from InspectionPath where inspectionid in (select id from Inspection where organization_id=%@)",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
    return [self autoParserForDataModel:@"InspectionPath" andInXMLString:webString];
}

@end
