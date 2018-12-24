//
//  DownListViewController.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/7.
//

#import <UIKit/UIKit.h>
#import "CaseIDHandler.h"


@interface CaseinfoDownListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic)  UIPopoverController *myPopover;
@property (nonatomic,weak) id<CaseIDHandler> delegate;
@property (retain, nonatomic)  UITableView *caseListView;
@property (retain,nonatomic) NSArray *caseList;
@property (retain,nonatomic) NSString* caseType;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshDataButton;

- (IBAction)refreshData:(id)sender;

@end
