//
//  DownListViewController.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/7.
//
#import "DataDownLoad.h"
#import "CaseinfoDownListViewController.h"
#import "InitCaseInfo.h"

#import "CaseInfo.h"
#import "RoadSegment.h"

@interface CaseinfoDownListViewController ()

//下载及提示
@property (nonatomic,retain) DataDownLoad * dataDownLoader;
@property (nonatomic,retain) UIAlertView * progressView;

@end
@implementation CaseinfoDownListViewController

@synthesize myPopover=_myPopover;
@synthesize delegate=_delegate;
@synthesize caseList=_caseList;
@synthesize caseListView = _caseListView;
@synthesize caseType = _caseType;

- (DataDownLoad *)dataDownLoader{
    _dataDownLoader = nil;
    if (_dataDownLoader == nil) {
        _dataDownLoader = [[DataDownLoad alloc] init];
    }
    return _dataDownLoader;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.preferredContentSize = CGSizeMake(380, 500);
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.caseListView.style
//    self.caseListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//style:UITableViewCellStyleSubtitle];
//    [self.view addSubview:self.caseListView];
    self.caseListView.delegate = self;
    self.caseListView.dataSource = self;
    self.caseList = [CaseInfo caseInfoForDownDatawithtypeID:self.caseType];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.caseList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.caseList = [CaseInfo caseInfoForDownDatawithtypeID:self.caseType];
    static NSString *CellIdentifier=@"CaseListCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CaseInfo *caseInfo=[self.caseList objectAtIndex:indexPath.row];
    NSString *roadName=[RoadSegment roadNameFromSegment:caseInfo.roadsegment_id];
    NSNumberFormatter *numFormatter=[[NSNumberFormatter alloc] init];
    [numFormatter setPositiveFormat:@"000"];
    NSInteger stationStartM=caseInfo.station_start.integerValue%1000;
    NSString *stationStartKMString=[NSString stringWithFormat:@"%02d", caseInfo.station_start.integerValue/1000];
    NSString *stationStartMString=[numFormatter stringFromNumber:[NSNumber numberWithInteger:stationStartM]];
    NSString *stationString;
    if (caseInfo.station_end.integerValue == 0 || caseInfo.station_end.integerValue == caseInfo.station_start.integerValue  ) {
        stationString=[NSString stringWithFormat:@"K%@+%@处",stationStartKMString,stationStartMString];
    } else {
        NSInteger stationEndM=caseInfo.station_end.integerValue%1000;
        NSString *stationEndKMString=[NSString stringWithFormat:@"%02d",caseInfo.station_end.integerValue/1000];
        NSString *stationEndMString=[numFormatter stringFromNumber:[NSNumber numberWithInteger:stationEndM]];
        stationString=[NSString stringWithFormat:@"K%@+%@至K%@+%@处",stationStartKMString,stationStartMString,stationEndKMString,stationEndMString ];
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    //案发时间字符串
    NSString * happenDate=[dateFormatter stringFromDate:caseInfo.happen_date];
    cell.textLabel.text=[[NSString alloc] initWithFormat:@"%@%@%@",roadName,caseInfo.side,stationString];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@年%@号   %@",caseInfo.case_mark2,caseInfo.full_case_mark3,happenDate];
    if (caseInfo.isuploaded.boolValue) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate  setCaseIDdelegate:[[self.caseList objectAtIndex:indexPath.row] valueForKey:@"myid"]];
    [self.myPopover dismissPopoverAnimated:YES];
}
//- (void)addliftofRightBarButton{
//   UIBarButtonItem *btn0 = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"刷新"  style:UIBarButtonItemStylePlain  target:self  action:@selector(refreshData:)];
////     [self.navigationItem setRightBarButtonItem:btn];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn0,btn,nil];
//}

- (IBAction)refreshData:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoaddataFinished:) name:@"DownLoadDataFinished" object:nil];
    if ([WebServiceHandler isServerReachable]) {
        self.progressView=[[UIAlertView alloc] initWithTitle:@"同步案件数据" message:@"正在努力加载数据，请稍候……" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        MAINDISPATCH(^(void){
            [self.progressView show];
        });
        NSString * currentUserID= [[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
//        NSString *orgID = [UserInfo userInfoForUserID:currentUserID].organization_id;
        [self.dataDownLoader DownLoadcaseinfoandalltable:currentUserID];
    }
}
- (void)downLoaddataFinished:(NSNotification *)noti{
    if (self.progressView != nil) {
        [self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
    }
    self.caseList = [CaseInfo caseInfoForDownDatawithtypeID:self.caseType];
    [self.caseListView reloadData];
}


@end
