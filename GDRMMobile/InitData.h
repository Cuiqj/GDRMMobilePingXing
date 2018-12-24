//
//  InitData.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-10-9.
//
//

#define WebServiceInit WebServiceHandler *service=[[WebServiceHandler alloc] init];\
                        service.delegate=self


#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"
#import "TBXML.h"

@interface InitData : NSObject<WebServiceReturnString>
@property (nonatomic,retain) NSString *currentOrgID;
- (id)initWithOrgID:(NSString *)orgID;
- (NSDictionary *)xmlParser:(NSString *)webString;
- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString;
//案件及巡查、施工等可以不清理本地创建数据刷新
- (NSDictionary *)autoParserForDataModel:(NSString *)dataModelName andInXMLString:(NSString *)xmlString andtype:(NSString *)type;

- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName adddataModel:(NSString *)dataModel withtypeID:(NSString *)typeID;
@end
