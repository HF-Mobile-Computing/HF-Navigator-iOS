
#import "NotificationsController.h"
#import "AFHTTPRequestOperationManager.h"
#import "NotificationDetailController.h"
#import "LLARingSpinnerView.h"
#import "UIColor+Hexadecimal.h"

@interface NotificationsController ()


@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation NotificationsController

@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.finished = [[NSArray alloc] init];
    [self LoadData];
    [self LoadDay];
    
    self.spinnerView = [[LLARingSpinnerView alloc]
                        initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    self.spinnerView.frame = CGRectMake((self.view.frame.size.width / 2) - (self.spinnerView.frame.size.width / 2), (self.view.frame.size.height / 2.5) - (self.spinnerView.frame.size.height / 2), 50, 50);
    
    self.spinnerView.lineWidth = 4.0f;
    
    self.spinnerView.tintColor = [UIColor colorWithHexString:@"#336699"];
    
    [self.view addSubview:self.spinnerView];
    
    [self.spinnerView startAnimating];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)updateTable
{
    [self LoadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    [tableView setBackgroundColor:[UIColor whiteColor]];
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notificationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UIView *v = [[UIView alloc] init];
    [v setBackgroundColor:[UIColor whiteColor]];

    cell.selectedBackgroundView = v;
    [cell setBackgroundColor: [UIColor whiteColor]];
    
    if (indexPath.row != 0) {
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width / 1.2, 83)];
    UILabel * time = [[UILabel alloc] initWithFrame:CGRectMake(25, 85, 250, 40)];
    
    name.numberOfLines = 3;
    time.numberOfLines = 1;
    
    name.font= [UIFont systemFontOfSize:19];
    time.font= [UIFont boldSystemFontOfSize:18];
    
    name.textColor = [UIColor blackColor];
    time.textColor = [UIColor blackColor];
    
    name.backgroundColor = [UIColor clearColor];
    time.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:name];
    [cell.contentView addSubview:time];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    name.text = [[self.notificationList objectAtIndex:indexPath.row] objectForKey:@"content"];
    time.text = [[self.notificationList objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    return cell;
        
    } else {

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height / 2, tableView.frame.size.width, 78)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        if ([self.day isEqualToString:@"B"]){
            
            [label setText:@"Today is a B day"];
            
        } else if ([self.day isEqualToString:@"A"]){
            
            [label setText:@"Today is an A day"];
            
        } else if ([self.day isEqualToString:@"none"]){
            
            [label setText:@"Today is no school day"];
        }
        
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0]];
        //
        //    label.layer.cornerRadius = 10.0;
        //    label.layer.masksToBounds = YES;
        
        [cell.contentView addSubview:label];
        
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)LoadData{
    
    [self.refreshControl beginRefreshing];

    NSString *url = @"http://www.harbingernews.net/notification_center.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.notificationList = [responseObject valueForKey:@"notification"];
        [self LoadDay];
        
        NSLog(@"%@", self.notificationList);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error.localizedDescription);
        
    }];
    
}

- (void)LoadDay {

    
    NSString *url = @"http://www.harbingernews.net/days.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.day = [responseObject valueForKey:@"aorb"];
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.spinnerView stopAnimating];
            [UIView animateWithDuration:0.25f animations:^{
                [self.tableView reloadData];
                self.spinnerView.hidden = true;
                
            } completion:nil];
        });
        NSLog(@"%@", [responseObject valueForKey:@"aorb"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error.localizedDescription);
        
    }];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0) {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[self.notificationList objectAtIndex:indexPath.row] objectForKey:@"time"]
                                                    message:[[self.notificationList objectAtIndex:indexPath.row] objectForKey:@"content"]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    }
}

@end
