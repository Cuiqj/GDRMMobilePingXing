////
////  WebServiceHandler.h
////  GDRMMobile
////
////  Created by yu hongwu on 12-2-23.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//
//@protocol WebServiceReturnString;
//
//@interface WebServiceHandler : NSObject;
//@property (nonatomic,retain) id<WebServiceReturnString> delegate;
//
//-(void)getPermitData:(NSString *)permitNo 
//           startDate:(NSString *)startdate 
//             endDate:(NSString *)enddate
//         permitOrgId:(NSString *)orgId;
//-(void)executeWebService:(NSString *)serviceName
//             serviceParm:(NSString *)parms;
//-(void)getPermitAppInfo:(NSString *)permit_no;
//-(void)getPermitUnlimitInfo:(NSString *)permit_no;
//-(void)getPermitAdvInfo:(NSString *)permit_no;
//-(void)getPermitAuditListInfo:(NSString *)permit_no;
//-(void)getPermitattechmentListInfo:(NSString *)permit_no;
//-(void)getOrgInfo;
//-(void)getUserInfo;
//-(void)getIconModels;
//-(NSString *)htmlEntityDecode:(NSString *)string;
////- (void)downloadDataSet:(NSString *)strSQL;
//- (void)downloadDataSet:(NSString *)strSQL  orgid:(NSString *)orgid;
//- (void)uploadDataSet:(NSString *)xmlDataFile;
//- (void)uploadDataSet:(NSString *)xmlDataFile
//       currentDataSet:(NSString *)currentDataName;
//- (void)uploadPhotot:(NSString *)xmlDataFile updatedObject:(id)updatedObject;
////测试网络连通性
//+ (BOOL)isServerReachable;
//@end
//
//@protocol WebServiceReturnString <NSObject>
//@optional
//- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName;
//- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName updatedObject:(id)updatedObject;
//- (void)requestTimeOut;
//- (void)requestUnkownError;
//
//@end
//
//  WebServiceHandler.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//
//  WebServiceHandler.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WebServiceReturnString;

@interface WebServiceHandler : NSObject;
@property (nonatomic,retain) id<WebServiceReturnString> delegate;

-(void)getPermitData:(NSString *)permitNo
           startDate:(NSString *)startdate
             endDate:(NSString *)enddate
         permitOrgId:(NSString *)orgId;
-(void)executeWebService:(NSString *)serviceName
             serviceParm:(NSString *)parms;
-(void)getPermitAppInfo:(NSString *)permit_no;
-(void)getPermitUnlimitInfo:(NSString *)permit_no;
-(void)getPermitAdvInfo:(NSString *)permit_no;
-(void)getPermitAuditListInfo:(NSString *)permit_no;
-(void)getPermitattechmentListInfo:(NSString *)permit_no;
-(void)getOrgInfo;
-(void)getUserInfo;
-(void)getIconModels;

- (void)downloadDataSet:(NSString *)strSQL;
- (void)downloadDataSet:(NSString *)strSQL orgid:(NSString *)orgid;
- (void)uploadDataSet:(NSString *)xmlDataFile;
- (void)uploadDataSet:(NSString *)xmlDataFile currentDataSet:(NSString *)currentDataName;
- (void)uploadPhotot:(NSString *)xmlDataFile updatedObject:(id)updatedObject;
//测试网络连通性
+ (BOOL)isServerReachable;


//下载案件或巡查及施工检查数据
- (void)downloadDataSet:(NSString *)strSQL withtypeID:(NSString *)typeID addtable:(NSString *)table;

@end

@protocol WebServiceReturnString <NSObject>
@optional
- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName;
- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName updatedObject:(id)updatedObject;
- (void)requestTimeOut;
- (void)requestUnkownError;


- (void)getWebServiceReturnString:(NSString *)webString forWebService:(NSString *)serviceName adddataModel:(NSString *)dataModel withtypeID:(NSString *)typeID;
@end
