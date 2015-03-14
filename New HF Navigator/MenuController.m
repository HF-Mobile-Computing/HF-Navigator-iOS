

#import "MenuController.h"
#import "UIViewController+REFrostedViewController.h"
#import "NavigationController.h"
#import "ResController.h"
#import "ToolsController.h"
#import "HFController.h"
#import "LiveStreamController.h"
#import "TeacherDirectoryController.h"
#import "HomeController.h"
#import "CustomIOS7AlertView.h"
#import "ArticlesController.h"

@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 164.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 80, 80)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"harbingerfrontlogo.png"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 0, 24)];
        label.text = @"HF Navigator";
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
    
//    NSString *string1 = @"Hello String";
//    
//    [string1 stringByAppendingString:@"string two"];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.2f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 0, 0)];
    label.text = @"Other";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NavigationController *navigationController = [self.storyboard
            instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        HomeController *homeController = [self.storyboard
            instantiateViewControllerWithIdentifier:@"homeController"];
        homeController.title = @"Home";
        navigationController.viewControllers = @[homeController];
        
    } else if (indexPath.section == 0 && indexPath.row == 1) {
            ResController *resController = [self.storyboard instantiateViewControllerWithIdentifier:@"resController"];
            resController.title = @"Resources";
            navigationController.viewControllers = @[resController];
        
    } else if (indexPath.section == 0 && indexPath.row == 2) {
      
        ToolsController *toolsController = [self.storyboard instantiateViewControllerWithIdentifier:@"toolsController"];
        toolsController.title = @"Tools";
        navigationController.viewControllers = @[toolsController];
        
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        TeacherDirectoryController *teacherController = [self.storyboard instantiateViewControllerWithIdentifier:@"teacherController"];
        teacherController.title = @"Teacher Directory";
        navigationController.viewControllers = @[teacherController];
        
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        HFController *hfController = [self.storyboard instantiateViewControllerWithIdentifier:@"hfController"];
        hfController.title = @"Harborfields";
        navigationController.viewControllers = @[hfController];

    } else if (indexPath.section == 0 && indexPath.row == 5) {
        LiveStreamController *liveStreamController = [self.storyboard instantiateViewControllerWithIdentifier:@"liveStreamController"];
        liveStreamController.title = @"Live Stream";
        navigationController.viewControllers = @[liveStreamController];
      
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        ArticlesController *articlesController = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"articlesController"];
        articlesController.title = @"Articles";
        navigationController.viewControllers = @[articlesController];
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ethanthomas33@gmail.com"]];

    } else if (indexPath.section == 1 && indexPath.row == 1) {
        
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        
        [alertView setContainerView:[self createDialogView]];
        
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Google+", @"Website", @"GitHub", @"Close",  nil]];
        
        [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            switch (buttonIndex) {
                case 0:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/u/0/+EthanThomas33/posts"]];
                    break;
                case 1:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ethanthomas.me"]];
                    break;
                case 2:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/ethanthomas"]];
                    break;
                case 3:
                    [alertView close];
                    break;
            }
        }];
        
//        [alertView setUseMotionEffects:true];
        
        [alertView show];
        
    } else {
        
        NSLog(@"Some weird error happened");
    }
    
    if (indexPath.section != 1) {
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(sectionIndex == 0)
    return 7;
    if (sectionIndex == 1)
        return 2;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Schedules", @"Tools", @"Teacher Directory", @"Harborfields", @"Sports Live Stream", @"Harbinger"];
        cell.textLabel.text = titles[indexPath.row];
//        
//       NSArray *images = [[NSArray alloc] initWithObjects:
//                     [UIImage imageNamed:@"home.png"],
//                     [UIImage imageNamed:@"resources.png"],
//                     [UIImage imageNamed:@"tools.png"],
//                     [UIImage imageNamed:@"teacherdir.png"],
//                     [UIImage imageNamed:@"hf.png"],
//                     [UIImage imageNamed:@"play.png"],
//                     [UIImage imageNamed:@"menu_feedback.png"],
//                     [UIImage imageNamed:@"info.png"], nil];
//        
//        cell.imageView.image = images[indexPath.row];
    
    } else {
        NSArray *titles = @[@"Send Feedback", @"About the Developer"];
        cell.textLabel.text = titles[indexPath.row];
    }
//
    return cell;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIView *)createDialogView {
    UIView * view = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 10, 180)];
    
    UIImageView * imageView = [[UIImageView alloc]
                               initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 30, 160)];
    imageView.image = [UIImage imageNamed:@"developer.jpg"];
    
    UILabel *developer = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, imageView.frame.size.height - 15, self.view.frame.size.width - 25, 20)];
    developer.text = @"Ethan Thomas";
    developer.textAlignment = NSTextAlignmentRight;
    developer.textColor = [UIColor whiteColor];
    developer.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    
    [view addSubview:imageView];
    [view addSubview:developer];
    
    return view;
}

@end
