//
//  DataDownLoad.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-10-22.
//
//

#import "DataDownLoad.h"
#import "AGAlertViewWithProgressbar.h"
#import "AlertViewWithProgressbar.h"
#import "OrgInfo.h"
#import "InitCarCheckItems.h"
#import "InitRoadasset_checkitem.h"
#import "OMGToast.h"
@interface DataDownLoad()
//@property (nonatomic,retain) AGAlertViewWithProgressbar *progressView;
@property (nonatomic,retain) AlertViewWithProgressbar *progressView;
@property (nonatomic,assign) NSInteger                parserCount;
@property (nonatomic,assign) NSInteger                currentParserCount;
/**
 *1下载成功
 *0下载失败
 *2正在等待前一个下载结束
 */
@property (nonatomic,assign) NSInteger stillParsing;

- (void)parserFinished:(NSNotification *)noti;
@end

@implementation DataDownLoad
@synthesize progressView       = _progressView;
@synthesize parserCount        = _parserCount;
@synthesize currentParserCount = _currentParserCount;
@synthesize stillParsing       = _stillParsing;

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parserFinished:) name:@"ParserFinished" object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setProgressView:nil];
}

- (void)startDownLoad:(NSString *)orgID{
    if ([WebServiceHandler isServerReachable]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        //self.progressView=[[AGAlertViewWithProgressbar alloc] initWithTitle:@"同步基础数据" message:@"正在下载，请稍候……" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        self.progressView=[[AlertViewWithProgressbar alloc] initWithTitle:@"同步基础数据" message:@"正在下载，请稍候……" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        MAINDISPATCH(^(void){
            [self.progressView show];
        });
        self.parserCount        = DOWNLOADCOUNT;
        self.currentParserCount = self.parserCount;
        @autoreleasepool {
            InitUser *initUser = [[InitUser alloc] init];
            [initUser downLoadUserInfo:orgID];
            WAITFORPARSER
            InitIconModel *initIcon = [[InitIconModel alloc] init];
            [initIcon downLoadIconModels:orgID];
            WAITFORPARSER
            InitProvince *initProvice = [[InitProvince alloc] init];
            [initProvice downloadProvince:orgID];
            WAITFORPARSER
            InitCities *initCities = [[InitCities alloc] init];
            [initCities downloadCityCode:orgID];
            WAITFORPARSER
            InitRoadSegment *initRoad = [[InitRoadSegment alloc] init];
            [initRoad downloadRoadSegment:orgID];
            WAITFORPARSER
            InitRoadAssetPrice *initRoadAssetPrice = [[InitRoadAssetPrice alloc] init];
            [initRoadAssetPrice downloadRoadAssetPrice:orgID];
            WAITFORPARSER
            InitInquireAnswerSentence *iias = [[InitInquireAnswerSentence alloc] init];
            [iias downloadInquireAnswerSentence:orgID];
            WAITFORPARSER
            InitInquireAskSentence *iiask = [[InitInquireAskSentence alloc] init];
            [iiask downloadInquireAskSentence:orgID];
            WAITFORPARSER
            InitCheckItemDetails *icid = [[InitCheckItemDetails alloc] init];
            [icid downloadCheckItemDetails:orgID];
            WAITFORPARSER
            InitCheckItems *icheckItems = [[InitCheckItems alloc] init];
            [icheckItems downloadCheckItems:orgID];
            WAITFORPARSER
            
            //11
            InitCheckType *iCheckType = [[InitCheckType alloc] init];
            [iCheckType downLoadCheckType:orgID];
            WAITFORPARSER
            InitCheckHandle *iCheckHandle = [[InitCheckHandle alloc] init];
            [iCheckHandle downLoadCheckHandle:orgID];
            WAITFORPARSER
            InitCheckReason *iCheckReason = [[InitCheckReason alloc] init];
            [iCheckReason downLoadCheckReason:orgID];
            WAITFORPARSER
            InitCheckStatus *iCheckStatus = [[InitCheckStatus alloc] init];
            [iCheckStatus downLoadCheckStatus:orgID];
            WAITFORPARSER
            InitSystype *iSystype = [[InitSystype alloc] init];
            [iSystype downloadSysType:orgID];
            WAITFORPARSER
            InitLaws *iLaws = [[InitLaws alloc] init];
            [iLaws downLoadLaws:orgID];
            WAITFORPARSER
            InitLawItems *iLawItems = [[InitLawItems alloc] init];
            [iLawItems downloadLawItems:orgID];
            WAITFORPARSER
            InitMatchLaw *iMatchLaw = [[InitMatchLaw alloc] init];
            [iMatchLaw downloadMatchLaw:orgID];
            WAITFORPARSER
            InitMatchLawDetails *iMatchLawDetails = [[InitMatchLawDetails alloc] init];
            [iMatchLawDetails downloadMatchLawDetails:orgID];
            WAITFORPARSER
            InitLawBreakingAction *iLawBreakingAction = [[InitLawBreakingAction alloc] init];
            [iLawBreakingAction downloadLawBreakingAction:orgID];
            WAITFORPARSER
            
            //21
            InitOrgInfo *iOrgInfo = [[InitOrgInfo alloc] init];
            [iOrgInfo downLoadOrgInfo:orgID];
            WAITFORPARSER
            InitFileCode *iFileCode = [[InitFileCode alloc] init];
            [iFileCode downLoadFileCode:orgID];
            WAITFORPARSER
//            InitBridge  *iBridge = [[InitBridge alloc] init];
//            [iBridge downLoadBridge:orgID];
//            WAITFORPARSER
            InitMaintainPlan  *iMaintianPlan = [[InitMaintainPlan alloc] init];
            [iMaintianPlan downMaintainPlan:orgID];
            WAITFORPARSER
            InitSfz *isfz = [[InitSfz alloc] init];
            [isfz downLoadSfz:orgID];
            WAITFORPARSER
            InitZd *izd =[[InitZd alloc]init];
            [izd downLoadZd:orgID];
            WAITFORPARSER
            InitServiceCheckItems *iservicesCheckItems=[[InitServiceCheckItems alloc]init];
            [iservicesCheckItems downLoadServiceCheckItems:orgID];
            WAITFORPARSER
//            InitServiceOrg *iservicesOrg=[[InitServiceOrg alloc]init];
//            [iservicesOrg downLoadServiceOrg:orgID];
//            WAITFORPARSER
            InitCarCheckItems *iCarCheckItems=[[InitCarCheckItems alloc]init];
            [iCarCheckItems downLoadCarCheckItems:orgID];
            WAITFORPARSER
//            InitRoadasset_checkitem *iRoadasset_checkitem=[[InitRoadasset_checkitem alloc]init];
//            [iRoadasset_checkitem downLoadRoadasset_checkitem:orgID];
//            WAITFORPARSER
            
            //31
//            InitInspection * insPectionData = [[InitInspection alloc] init];
//            [insPectionData downloadInspectionforOrgID:orgID];
//            WAITFORPARSER
//            InitInspectionPath * insPectionpathData = [[InitInspectionPath alloc] init];
//            [insPectionpathData downloadInspectionPathforOrgID:orgID];
//            WAITFORPARSER
//            InitInspectionRecord * insPectionRecordData = [[InitInspectionRecord alloc] init];
//            [insPectionRecordData downloadInspectionRecordforOrgID:orgID];
//            WAITFORPARSER
//            InitBridgeCheckItem *iInitBridgeCheckItem=[[InitBridgeCheckItem alloc]init];
//            [iInitBridgeCheckItem downLoadBridgeCheckItem:orgID];
//            WAITFORPARSER
//            InitCaseInfo * caseinfoitem = [[InitCaseInfo alloc] init];
//            [caseinfoitem downLoadcaseinfofortable:@"CaseInfo" withorgID:orgID withtypeID:nil];
//            WAITFORPARSER
//            InitCaseInquire * inquireData = [[InitCaseInquire alloc] init];
//            [inquireData downloadCaseInquireforOrgID:orgID];
//            WAITFORPARSER
//            InitCaseMap * mapData = [[InitCaseMap alloc] init];
//            [mapData downloadCaseMapforOrgID:orgID];
//            WAITFORPARSER
//            InitCitizen * citizenData = [[InitCitizen alloc] init];
//            [citizenData downloadCitizenforOrgID:orgID];
//            WAITFORPARSER
//            InitCaseProveInfo * ProveInfoData = [[InitCaseProveInfo alloc] init];
//            [ProveInfoData downloadCaseProveInfoforOrgID:orgID];
//            WAITFORPARSER
//            InitCaseDeformation * deformationData = [[InitCaseDeformation alloc] init];
//            [deformationData downloadCaseDeformationforOrgID:orgID];
//            WAITFORPARSER
           
            
            
            
            
            extern NSString *my_org_id;
            //my_org_id=orgID;
            // OrgInfo *selectedorg = orgInfoForOrgID
            OrgInfo *selectedorg = [OrgInfo orgInfoForOrgID:orgID];
            //        NSArray *upLoadedDataArray = [NSClassFromString(upLoadedDataName) uploadArrayOfObject];
            //        for (id obj in upLoadedDataArray) {
            //            [obj setValue:@(YES) forKey:@"isuploaded"];
            //        }
            [selectedorg setValue:@(YES) forKey:@"isselected"];
        }
    }
}

- (void)parserFinished:(NSNotification *)noti{
    NSDictionary *info=[noti userInfo];
    NSString * dataModelName=[info objectForKey:@"dataModelName"];
    if([dataModelName isEqualToString:@"CaseInquire"]){
        int i =0;
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.progressView isVisible]) {
            self.currentParserCount = self.currentParserCount-1;
            [self.progressView setProgress:(int)(((float)(-self.currentParserCount+self.parserCount)/(float)self.parserCount)*100.0)];
            
            NSDictionary *info=[noti userInfo];
            
            NSString* success=[info objectForKey:@"success"];
            if ([success isEqualToString:@"0"]) {
                self.stillParsing = 0;
                NSString *dataModelName=[info objectForKey:@"dataModelName"];
                [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                double delayInSeconds   = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // [self.progressView hide];
                    [ self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADFINISHNOTI object:nil];
                    UIAlertView *finishAlert = [[UIAlertView alloc] initWithTitle:@"消息" message:[NSString stringWithFormat:@"%@下载出错,请仔细检查下载地址是否正确或者重新下载",dataModelName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [finishAlert show];
                });
                return;
            }
            if ([success isEqualToString:@"2"]) {
                self.stillParsing = 1;
                NSString *dataModelName=[info objectForKey:@"dataModelName"];
                /*
                 [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                 double delayInSeconds   = 0.5;
                 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // [self.progressView hide];
                 [ self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
                 //                    [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADFINISHNOTI object:nil];
                 UIAlertView *finishAlert = [[UIAlertView alloc] initWithTitle:@"消息" message:[NSString stringWithFormat:@"%@表缺少基础数据，请在网页上添加后再下载一次",dataModelName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [finishAlert show];
                 });
                 */
                [OMGToast showWithText:[NSString stringWithFormat:@"%@表缺少数据，请在网页上添加数据后再下载一次",dataModelName] bottomOffset:100 duration:2];
            }
            self.stillParsing = 1;
            if (self.currentParserCount==0) {
                [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                double delayInSeconds   = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // [self.progressView hide];
                    [ self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
                    
                    UIAlertView *finishAlert = [[UIAlertView alloc] initWithTitle:@"消息" message:@"下载完毕" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [finishAlert show];
//
                });
            }
        }
    });
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.selectType isEqualToString:@"选择机构"]) {
//        exit(0);
        [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADFINISHNOTI object:nil];
    }
}

- (void)DownLoadcaseinfoandalltable:(NSString *)orgID{
    InitCaseInfo * caseinfoData = [[InitCaseInfo alloc] init];
    [caseinfoData downLoadcaseinfofortable:@"CaseInfo" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
    InitCaseMap * mapData = [[InitCaseMap alloc] init];
    [mapData downLoadCaseMapfortable:@"CaseMap" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
    InitCitizen * citizenData = [[InitCitizen alloc] init];
    [citizenData downLoadCitizenfortable:@"Citizen" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
    InitCaseProveInfo * ProveInfoData = [[InitCaseProveInfo alloc] init];
    [ProveInfoData downLoadCaseProveInfofortable:@"CaseProveInfo" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
    InitCaseDeformation * deformationData = [[InitCaseDeformation alloc] init];
    [deformationData downLoadCaseDeformationfortable:@"CaseDeformation" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
    InitCaseInquire * inquireData = [[InitCaseInquire alloc] init];
    [inquireData downLoadCaseInquirefortable:@"CaseInquire" withorgID:orgID withtypeID:nil];
//        WAITFORPARSER
}

- (void)DownLoadInspectionandalltable:(NSString *)orgID{
    InitInspection * insPectionData = [[InitInspection alloc] init];
    [insPectionData downloadInspectionforOrgID:orgID];
//    WAITFORPARSER
    InitInspectionPath * insPectionpathData = [[InitInspectionPath alloc] init];
    [insPectionpathData downloadInspectionPathforOrgID:orgID];
//    WAITFORPARSER
    InitInspectionRecord * insPectionRecordData = [[InitInspectionRecord alloc] init];
    [insPectionRecordData downloadInspectionRecordforOrgID:orgID];
//    WAITFORPARSER
   

}

@end
