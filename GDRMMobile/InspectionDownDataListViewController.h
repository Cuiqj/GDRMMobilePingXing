//
//  InspectionDownDataListViewController.h
//  GDRMXBYHMobile
//
//  Created by admin on 2018/12/12.
//

#import <UIKit/UIKit.h>

@protocol InspectionListDelegate;

@interface InspectionDownDataListViewController : UITableViewController



@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshDataButton;


@property (nonatomic, weak) id<InspectionListDelegate> delegate;
@property (nonatomic, weak) UIPopoverController * popover;

- (IBAction)refreshData:(id)sender;

@end


@protocol InspectionListDelegate <NSObject>

- (void)setCurrentInspection:(NSString *)inspectionID anddowndata:(BOOL)isdowndata;

@end
