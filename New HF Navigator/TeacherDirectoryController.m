
#import "TeacherDirectoryController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIColor+Hexadecimal.h"
#import "LLARingSpinnerView.h"
#import "TeacherDirectoryDetailController.h"

@interface TeacherDirectoryController ()


@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TeacherDirectoryController

@synthesize table;

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
    
}

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
    [self.tabBarController.viewControllers makeObjectsPerformSelector:@selector(view)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF774C"];
    
    self.finished = [[NSArray alloc] init];
    [self LoadData];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.spinnerView = [[LLARingSpinnerView alloc]
                        initWithFrame:CGRectMake(0, 0, 50, 50)];
    
 self.spinnerView.frame = CGRectMake((self.view.frame.size.width / 2) - (self.spinnerView.frame.size.width / 2), (self.view.frame.size.height / 2.5) - (self.spinnerView.frame.size.height / 2), 50, 50);
    
    self.spinnerView.lineWidth = 4.0f;
    
    self.spinnerView.tintColor = [UIColor colorWithHexString:@"#336699"];
    
    [self.view addSubview:self.spinnerView];
    
    [self.spinnerView startAnimating];
    
    [super viewDidLoad];
}

- (void)updateTable
{
    [self LoadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    [tableView setBackgroundColor:[UIColor whiteColor]];
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teacherList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UIView *background = [[UIView alloc] initWithFrame:cell.frame];
    background.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    background.opaque = YES;
    
    UIView *v = [[UIView alloc] init];
    [v setBackgroundColor:[UIColor whiteColor]];

    [cell setBackgroundColor: [UIColor whiteColor]];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, cell.frame.size.width, cell.frame.size.height)];
    UILabel * letter = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, cell.frame.size.width, cell.frame.size.height)];
    
    name.numberOfLines = 3;
    letter.numberOfLines = 1;
    
    name.frame = CGRectMake(90, 10, cell.frame.size.width - 65, 83);
    letter.frame = CGRectMake(41, 17, 65, 65);
    
    name.font= [UIFont fontWithName:@"HelveticaNeue-Thin" size:19.0];
    letter.font= [UIFont fontWithName:@"HelveticaNeue-Thin" size:27];
    
    name.textColor = [UIColor blackColor];
    letter.textColor = [UIColor whiteColor];
    
    name.backgroundColor = [UIColor clearColor];
    letter.backgroundColor = [UIColor clearColor];
    

    self.colorArray = [NSMutableArray arrayWithObjects: @"#4AB86E", @"#3399FF",
                             @"#009688", @"#E64545", @"#FF774C", nil];
    
    int randomIndex = arc4random_uniform([self.colorArray count]);

    //------Circle behind letter ---------------
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(21, 22, 55, 55)];
    
    self.circleView.layer.cornerRadius = 55/2;
    NSString * randomColorString = [self.colorArray objectAtIndex:randomIndex];
    
    self.circleView.backgroundColor = [UIColor colorWithHexString:randomColorString];
    
    [self.colorList addObject:randomColorString];
    
    [cell.contentView addSubview:self.circleView];
    //------------end circleview-------------------
    
    [cell.contentView addSubview:name];
    [cell.contentView addSubview:letter];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    name.text = [[self.teacherList objectAtIndex:indexPath.row] objectForKey:@"name"];

    NSArray * array = [[[self.teacherList objectAtIndex:indexPath.row] objectForKey:@"name"] componentsSeparatedByString:@" "];

    if (array.count == 2)
        letter.text = [[array objectAtIndex:1] substringToIndex:1];
    if (array.count == 3)
        letter.text = [[array objectAtIndex:2] substringToIndex:1];
    if (array.count == 4)
        letter.text = [[array objectAtIndex:3] substringToIndex:1];
    if (array.count == 5)
        letter.text = [[array objectAtIndex:4] substringToIndex:1];
    if (array.count == 6)
        letter.text = [[array objectAtIndex:5] substringToIndex:1];
    
  
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)LoadData{
    
    NSString *url = @"http://www.harbingernews.net/teacher_directory.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.teacherList = responseObject;
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.spinnerView stopAnimating];
            [UIView animateWithDuration:0.25f animations:^{
                
                self.spinnerView.hidden = true;
                [self.tableView reloadData];
                
            } completion:nil];
        });
        
        NSLog(@"%@", self.teacherList);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error.localizedDescription);
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TeacherDirectoryDetailController * detController = [self.storyboard
                                                    instantiateViewControllerWithIdentifier:@"teacherDirectoryDetailController"];
    detController.name = [[self.teacherList objectAtIndex:indexPath.row] objectForKey:@"name"];
    detController.email = [[self.teacherList objectAtIndex:indexPath.row] objectForKey:@"email"];
    detController.position = [[self.teacherList objectAtIndex:indexPath.row] objectForKey:@"position"];
        
    [detController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:detController animated:YES completion:nil];

//    [self.navigationController pushViewController:detController animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
