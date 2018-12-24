//
//  InitInspection.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/12.
//

#import "InitInspection.h"

@implementation InitInspection


- (void)downloadInspectionforOrgID:(NSString *)orgID{
    WebServiceInit;
    //[service downloadDataSet:@"select * from CityCode"orgid:orgID];
    [service downloadDataSet:[NSString stringWithFormat:@"select * from Inspection where organization_id=%@",orgID]];
}

- (NSDictionary *)xmlParser:(NSString *)webString{
    return [self autoParserForDataModel:@"Inspection" andInXMLString:webString];
}

@end
