//
//  InspectionDownDataListViewController.m
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/12.
//

#import "DataDownLoad.h"

#import "InspectionDownDataListViewController.h"
#import "Inspection.h"

@interface InspectionDownDataListViewController ()
@property (nonatomic, retain) NSMutableArray *data;

@property (nonatomic,retain) DataDownLoad * dataDownLoader;
@property (nonatomic,retain) UIAlertView * progressView;
@end

@implementation InspectionDownDataListViewController
@synthesize data;
@synthesize delegate;
@synthesize popover;

- (DataDownLoad *)dataDownLoader{
    _dataDownLoader = nil;
    if (_dataDownLoader == nil) {
        _dataDownLoader = [[DataDownLoad alloc] init];
    }
    return _dataDownLoader;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.preferredContentSize = CGSizeMake(400, 500);
}
- (void)viewDidLoad{
   
//    [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"refresh.png"] target:self action:nil];
    
    self.data = [NSMutableArray arrayWithArray:[Inspection inspectionForDownData]];
    [super viewDidLoad];

//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor grayColor];//加上背景颜色,方便观察Button的大小
//    //设置图片
//    NSString * strImage = [[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"png"];
//    UIImage * imageForButton = [UIImage imageWithContentsOfFile:strImage];
//    [button setImage:imageForButton forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    NSString * strImage = [[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"png"];
//    [self.refreshDataButton setImage:[UIImage imageWithContentsOfFile:strImage]];
    
//    self.navigationItem.rightBarButtonItem.image = [UIImage imageWithContentsOfFile:strImage];
//    UIBarButtonItem * btn0 = [[UIBarButtonItem alloc] initWithTitle:@" "  style:UIBarButtonItemStyleDone target:nil action:nil];
    //   已上传数据
//    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"已上传案件"
//                                                             style:UIBarButtonItemStylePlain
//                                                            target:self
//                                                            action:@selector(downloadDataShow:)];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn0,self.refreshDataButton,nil];

}
- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.data = [NSMutableArray arrayWithArray:[Inspection inspectionForDownData]];
    static NSString *CellIdentifier = @"InspectionListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Inspection *inspection = [self.data objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:inspection.date_inspection];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@  %@",dateString,inspection.recorder_name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",inspection.classe, inspection.inspection_place];
    // Configure the cell...
    if (inspection.isuploaded.boolValue) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Table view delegat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Inspection *inspection = [self.data objectAtIndex:indexPath.row];
    [self.delegate setCurrentInspection:inspection.myid anddowndata:YES];
    [self.popover dismissPopoverAnimated:YES];
}

- (IBAction)refreshData:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoaddataFinished:) name:@"DownLoadDataFinished" object:nil];
    if ([WebServiceHandler isServerReachable]) {
        self.progressView=[[UIAlertView alloc] initWithTitle:@"同步案件数据" message:@"正在努力加载数据，请稍候……" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        MAINDISPATCH(^(void){
            [self.progressView show];
        });
        NSString * currentUserID= [[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
        //        NSString *orgID = [UserInfo userInfoForUserID:currentUserID].organization_id;
        [self.dataDownLoader DownLoadInspectionandalltable:currentUserID];
    }    
}
- (void)downLoaddataFinished:(NSNotification *)noti{
    if (self.progressView != nil) {
        [self.progressView dismissWithClickedButtonIndex:-1 animated:YES];
    }
    self.data = [NSMutableArray arrayWithArray:[Inspection inspectionForDownData]];
    [self.tableView reloadData];
}

@end
